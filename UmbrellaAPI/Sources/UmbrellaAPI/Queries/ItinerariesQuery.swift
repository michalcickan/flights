import Foundation

struct ItinerariesQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "itineraries" }
    
    let parameters: Parameters? = nil
    
    var body: Body
}

extension ItinerariesQuery {
    struct Body: QueryStringConvertible {
        let onItineraryOneWay: OnItineraryOneWayQuery
    }
}
