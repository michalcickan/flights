import Foundation
import Combine

protocol  FlightListInput: AnyObject {
    var onAppear: PassthroughSubject<Void, Never> { get }
}

protocol  FlightListOutput: ObservableObject {
    var flights: [CardViewModel] { get }
    var showRoute: AnyPublisher<SceneRoute, Never> { get }
}

protocol  FlightListViewModelType: ObservableObject {
    var input:  FlightListInput { get set }
    var output: any FlightListOutput { get }
}
