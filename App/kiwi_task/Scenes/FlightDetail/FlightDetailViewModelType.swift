import Foundation
import Combine

protocol  FlightDetailInput: AnyObject {
    
}

enum HighlightType {
    case best, fastest, cheapest, none
}
protocol  FlightDetailOutput: ObservableObject {
    var direction: String { get }
    
    var price: String { get }
    
    var totalDuration: String { get }
    
    var stops: ListSection<CardViewModel> { get }
    
    var bookingLinks: [LinkViewModel] { get }
    
    var highlightTag: HighlightType { get }
    
    var title: String { get }
}

protocol  FlightDetailViewModelType: ObservableObject {
    var input:  FlightDetailInput { get set }
    var output:  any FlightDetailOutput { get }
}
