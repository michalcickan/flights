import Foundation

struct ItinerariesQuery: QueryObject, StringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "itineraries" }
    
    let parameters: Parameters? = nil
    
    var body: Body
}

extension ItinerariesQuery {
    struct Body: StringConvertible {
        
    }
}
