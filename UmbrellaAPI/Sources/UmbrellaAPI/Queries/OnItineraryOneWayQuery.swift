import Foundation

struct OnItineraryOneWayQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "... on ItineraryOneWay" }
    
    let parameters: Parameters? = nil
    let body: Body
}

extension OnItineraryOneWayQuery {
    struct Body: QueryStringConvertible {
        let id: String?
        let duration: String?
        let type: String?
        let source: SectorQuery
    }
}

struct SectorQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "sector" }
    let parameters: EmptyParameters? = nil
    let body: Body
}

extension SectorQuery {
    struct Body: QueryStringConvertible {
        
    }
}
