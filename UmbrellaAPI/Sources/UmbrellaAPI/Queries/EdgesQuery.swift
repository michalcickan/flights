import Foundation

struct EdgesQuery: QueryObject, StringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "edges" }
    let parameters: Parameters? = nil
    let body: Body
}

extension EdgesQuery {
    struct Body: StringConvertible {
        let node: NodeQuery
    }
}
