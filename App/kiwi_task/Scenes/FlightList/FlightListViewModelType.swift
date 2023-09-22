import Foundation
import Combine



protocol  FlightListInput: AnyObject {
    var onAppear: PassthroughSubject<Void, Never> { get }
    var currentSegmentIndex: Int { get set }
    var onFiltersTap: PassthroughSubject<Void, Never> { get }
}

protocol  FlightListOutput: ObservableObject {
    typealias Day = DataState<[FlightCardViewModel]>
    
    var day: Day { get }
    var showRoute: AnyPublisher<SceneRoute, Never> { get }
    var segmentTitles: [String] { get }
}

protocol  FlightListViewModelType: ObservableObject {
    var input: FlightListInput { get set }
    var output: any FlightListOutput { get }
}
