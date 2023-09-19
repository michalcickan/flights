import Foundation

public struct PlacesQueryParameters: ParametersStringConvertible {
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
    public struct Search: ParametersStringConvertible {
        let term: String?
    }

    public struct Filter: ParametersStringConvertible {
        let onlyTypes: [PlaceType]
        let groupByCity: Bool?
    }

    public enum PlaceType: String, ParametersStringConvertible {
        case airport = "AIRPORT"
        case city = "CITY"
    }

    public struct Options: ParametersStringConvertible {
        enum SortBy: String {
            case rank = "RANK"
        }
        
        let sortBy: SortBy
    }
}
