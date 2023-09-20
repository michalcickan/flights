import Foundation
import Combine

class FilterOptionsViewModel: FilterOptionsOutput {
    private var _showRoute = PassthroughSubject<SceneRoute, Never>()
    var showRoute: AnyPublisher<SceneRoute, Never> {
        _showRoute.eraseToAnyPublisher()
    }
    
    var input: FilterOptionsInput = Input()
    
    init(service: FilterOptionsServiceType = FilterOptionsService()) {
        
    }
}

extension FilterOptionsViewModel {
    class Input: FilterOptionsInput {
        
    }
}

extension FilterOptionsViewModel: FilterOptionsViewModelType {
    var output: any FilterOptionsOutput { self }
}
