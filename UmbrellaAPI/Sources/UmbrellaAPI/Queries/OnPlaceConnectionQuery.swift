import Foundation

struct OnPlaceConnectionQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "... on PlaceConnection" }
    
    let parameters: Parameters? = nil
    let body: Body
}

extension OnPlaceConnectionQuery {
    struct Body: QueryStringConvertible {
        let edges: EdgesQuery
    }
}
