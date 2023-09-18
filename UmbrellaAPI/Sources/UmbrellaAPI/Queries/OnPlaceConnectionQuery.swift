import Foundation

struct OnPlaceConnectionQuery: QueryObject, StringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "... on PlaceConnection" }
    
    let parameters: Parameters? = nil
    let body: Body
}

extension OnPlaceConnectionQuery {
    struct Body: StringConvertible {
        let edges: EdgesQuery
    }
}
