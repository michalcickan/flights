import Foundation

struct PlacesQuery: QueryObject, QueryStringConvertible {
    typealias Parameters = PlacesQueryParameters
    
    var name: String { "places" }
    let parameters: Parameters?
    let body: Body
}

extension PlacesQuery {
    struct Body: QueryStringConvertible {
        let placeConnection: OnPlaceConnectionQuery
    }
}
