import Foundation

struct ItineraryOneWayQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "... on ItineraryOneWay" }
    
    let parameters: Parameters? = nil
    let body: Body
}

extension ItineraryOneWayQuery {
    struct Body: QueryStringConvertible {
        let onItineraries: OnItinerariesQuery
    }
}
