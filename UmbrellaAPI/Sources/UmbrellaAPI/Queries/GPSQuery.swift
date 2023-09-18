import Foundation

struct GPSQuery: QueryObject, StringConvertible {
    typealias Parameters = EmptyParameters
    
    var name: String { "gps" }
    let parameters: Parameters? = nil
    let body: Body
}

extension GPSQuery {
    struct Body: StringConvertible {
        let lng: String?
        let lat: String?
    }
}
