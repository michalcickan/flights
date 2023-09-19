import Foundation

struct EdgesQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "edges" }
    let parameters: Parameters? = nil
    let body: Body
}

extension EdgesQuery {
    struct Body: QueryStringConvertible {
        let node: NodeQuery
    }
}
