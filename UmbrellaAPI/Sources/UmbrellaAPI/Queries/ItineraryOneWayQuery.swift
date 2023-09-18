import Foundation

struct ItineraryOneWayQuery: QueryObject, StringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "... on ItineraryOneWay" }
    
    let parameters: Parameters? = nil
    let body: Body
}

extension ItineraryOneWayQuery {
    struct Body: StringConvertible {
        let onItineraries: OnItinerariesQuery
    }
}
