import Foundation

public struct PlacesQueryParameters: ObjectStringConvertible {
    let search: Search?
    let filter: Filter?
    let options: Options?
    let first: Int?
    
    public init(search: PlacesQueryParameters.Search? = nil,
                filter: PlacesQueryParameters.Filter? = nil,
                options: PlacesQueryParameters.Options? = nil,
                first: Int? = nil) {
        self.search = search
        self.filter = filter
        self.options = options
        self.first = first
    }
}

extension PlacesQueryParameters {
    public struct Search: ObjectStringConvertible {
        let term: String?
    }

    public struct Filter: ObjectStringConvertible {
        let onlyTypes: [PlaceType]
        let groupByCity: Bool?
    }

    public enum PlaceType: String, SimpleValueStringConvertible {
        case airport = "AIRPORT"
        case city = "CITY"
    }

    public struct Options: ObjectStringConvertible {
        enum SortBy: String, SimpleValueStringConvertible {
            case rank = "RANK"
        }
        
        let sortBy: SortBy
    }
}
