import Foundation

struct NodeQuery: QueryObject, StringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "node" }
    let parameters: Parameters? = nil
    let body: Body
}

extension NodeQuery {
    struct Body: StringConvertible {
        let id: String
        let legacyId: String
        let gps: GPSQuery
    }
}
