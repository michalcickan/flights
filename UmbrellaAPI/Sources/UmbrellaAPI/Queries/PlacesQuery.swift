import Foundation

struct PlacesQuery: QueryObject, StringConvertible {
    typealias Parameters = PlacesQueryParameters
    
    var name: String { "places" }
    let parameters: Parameters?
    let body: Body
}

extension PlacesQuery {
    struct Body: StringConvertible {
        let placeConnection: OnPlaceConnectionQuery
    }
}
