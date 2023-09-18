import Foundation

struct OnItineraryOneWayQuery: QueryObject, StringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "... on ItineraryOneWay" }
    
    let parameters: Parameters? = nil
    let body: Body
}

extension OnItineraryOneWayQuery {
    struct Body: StringConvertible {
        
    }
}
