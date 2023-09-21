import Foundation
import UmbrellaAPI
import Combine

class SearchPlacesViewModel: SearchPlacesInput {
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
                    return (query.count < SearchPlacesViewModel.minChars
                            ? Future { promise in promise(.success([])) }
                            : service.fetch(query: query)
                    )
                    .catch { [weak self] error in
                        self?._showError.send(error.localizedDescription)
                        return Just<[PlaceEdge]>([])
                    }
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
                self._close.send(())
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
                            self.selectedEdges.send(self.selectedEdges.value + [edge])
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
