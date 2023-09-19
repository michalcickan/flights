import Foundation

struct OnItineraryOneWayQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "... on ItineraryOneWay" }
    
    let parameters: Parameters? = nil
    let body: Body
}

extension OnItineraryOneWayQuery {
    struct Body: QueryStringConvertible {
        
    }
}
