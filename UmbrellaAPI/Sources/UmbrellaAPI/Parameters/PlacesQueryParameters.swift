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
        let ids: [String]?
        
        public init(term: String? = nil, ids: [String]? = nil) {
            self.term = term
            self.ids = ids
        }
    }

    public struct Filter: ObjectStringConvertible {
        let onlyTypes: [PlaceType]
        let groupByCity: Bool?
        
        public init(onlyTypes: [PlacesQueryParameters.PlaceType], groupByCity: Bool? = nil) {
            self.onlyTypes = onlyTypes
            self.groupByCity = groupByCity
        }
    }

    public enum PlaceType: String, SimpleValueStringConvertible {
        case airport = "AIRPORT"
        case city = "CITY"
    }

    public struct Options: ObjectStringConvertible {
        public enum SortBy: String, SimpleValueStringConvertible {
            case rank = "RANK"
            case rankDistance = "RANK_DISTANCE"
            case rankDistanceTerm = "RANK_DISTANCE_TERM"
        }
        
        let gps: GPS?
        let sortBy: SortBy?
        
        public init(gps: GPS? = nil, sortBy: PlacesQueryParameters.Options.SortBy? = nil) {
            self.gps = gps
            self.sortBy = sortBy
        }
    }
}
