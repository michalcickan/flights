import Foundation

struct OnItinerariesQuery: QueryObject {
    typealias Parameters = EmptyParameters
    
    var name: String { "... on Itineraries" }
    
    let parameters: Parameters? = nil
    let body: Body
}

extension OnItinerariesQuery {
    struct Body: QueryStringConvertible {
        let itineraries: ItinerariesQuery?
    }
}
