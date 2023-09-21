import Foundation
import Combine

final class FlightListViewModel: ObservableObject, FlightListOutput {
    var input: FlightListInput = Input()
    
    @Published var test = "test"
    @Published var flights: [CardViewModel] = []
    let _showRoute = PassthroughSubject<SceneRoute, Never>()
    var showRoute: AnyPublisher<SceneRoute, Never> {
        _showRoute.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(service: FlightListServiceType, persistStore: PersistenStorage) {
        input.onAppear
            .sink(receiveValue: { [unowned self] in
                _showRoute.send(.filter)
            })
            .store(in: &cancellables)
    }
}

extension FlightListViewModel: FlightListViewModelType {
    var output: any FlightListOutput { self }
}

extension FlightListViewModel {
    final class Input: FlightListInput {
        let onAppear = PassthroughSubject<Void, Never>()
    }
}
