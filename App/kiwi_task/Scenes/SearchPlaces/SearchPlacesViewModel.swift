import Foundation
import UmbrellaAPI
import Combine

final class SearchPlacesViewModel: SearchPlacesInput {
    typealias Done = ([PlaceEdge]) -> Void
    private static let minChars = 3
    // Input
    @Published var searchText: String = ""
    var confirm = PassthroughSubject<Void, Never>()
    
    // Output
    @Published var items: [SearchItem] = []
    
    private var selectedEdges = CurrentValueSubject<[PlaceEdge], Never>([])
    
    var _showError = PassthroughSubject<String, Never>()
    var showError: AnyPublisher<String, Never> {
        _showError.eraseToAnyPublisher()
    }
    
    var _close = PassthroughSubject<Void, Never>()
    var close: AnyPublisher<Void, Never> {
        _close.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(service: SearchPlacesServiceType,
         done: @escaping Done) {
        Publishers.CombineLatest(
            $searchText
                .debounce(for: .milliseconds(300), scheduler: DispatchQueue.global())
                .flatMap { [weak self] query in
                    self?.selectedEdges.send([])
                    return (
                        query.count < SearchPlacesViewModel.minChars
                        ? Future { promise in promise(.success([])) }
                        : service.fetch(query: query)
                    )
                    .makeOptionableIfError(self?._showError)
                    .compactMap { $0 }
                },
            selectedEdges
        )
        .map(mapEdges)
        .receive(on: RunLoop.main)
        .assign(to: \.items, on: self)
        .store(in: &cancellables)
        
        confirm
            .sink { [unowned self] in
                if !self.selectedEdges.value.isEmpty {
                    done(self.selectedEdges.value)
                }
                self._close.send()
            }
            .store(in: &cancellables)
    }
}

extension SearchPlacesViewModel: SearchPlacesOutput {
    var mapEdges: ([PlaceEdge], [PlaceEdge]) -> [SearchItem] {
        { [weak self] edges, selectedEdges in
            guard !edges.isEmpty else {
                return [.empty("Type at least \(SearchPlacesViewModel.minChars) chars or valid name")]
            }
            return edges.map { edge in
                    .searchResult(
                        TileViewModel(
                            title: edge.node?.name ?? "-",
                            isSelected: selectedEdges.contains(where: { $0.node?.id == edge.node?.id })
                        ) {
                            guard let self else { return }
                            var currentEdges = self.selectedEdges.value
                            guard let index = currentEdges.firstIndex(where: { edge.node?.id == $0.node?.id }) else {
                                self.selectedEdges.send(currentEdges + [edge])
                                return
                            }
                            currentEdges.remove(at: index)
                            self.selectedEdges.send(currentEdges)
                        }
                    )
            }
        }
    }
}

extension SearchPlacesViewModel: SearchPlacesViewModelType {
    var input: SearchPlacesInput { get { self } set { } }
    var output: any SearchPlacesOutput { self }
}

fileprivate extension SearchPlacesServiceType {
    func fetch(query: String) -> Future<[PlaceEdge], Error> {
        Future { promise in
            Task {
                do {
                    let result = try await self.searchPlaces(
                        parameters: PlacesQueryParameters(
                            search: .init(term: query),
                            filter: .init(
                                onlyTypes: [.airport, .city],
                                groupByCity: true
                            ),
                            options: .init(sortBy: .rank),
                            first: 20
                        )
                    )
                    promise(.success(result))
                } catch  {
                    promise(.failure(error))
                }
            }
        }
    }
}
