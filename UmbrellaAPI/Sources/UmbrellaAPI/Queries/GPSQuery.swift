import Foundation

struct GPSQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "gps" }
    let parameters: Parameters? = nil
    let body: Body
}

extension GPSQuery {
    struct Body: QueryStringConvertible {
        let lng: String?
        let lat: String?
    }
}
