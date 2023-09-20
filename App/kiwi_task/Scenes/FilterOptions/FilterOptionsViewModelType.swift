import Foundation
import Combine

protocol FilterOptionsInput: AnyObject {
    
}

protocol  FilterOptionsOutput: ObservableObject {
    var showRoute: AnyPublisher<SceneRoute, Never> { get }
}

protocol  FilterOptionsViewModelType: ObservableObject {
    var input:  FilterOptionsInput { get set }
    var output:  any FilterOptionsOutput { get }
}
