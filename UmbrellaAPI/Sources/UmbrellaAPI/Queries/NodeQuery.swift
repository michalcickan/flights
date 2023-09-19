import Foundation

struct NodeQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "node" }
    let parameters: Parameters? = nil
    let body: Body
}

extension NodeQuery {
    struct Body: QueryStringConvertible {
        let id: String?
        let legacyId: String?
        let gps: GPSQuery
    }
}
