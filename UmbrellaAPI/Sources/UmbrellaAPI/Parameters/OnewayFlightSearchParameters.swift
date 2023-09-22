import Foundation

public struct OnewayFlightSearchParameters: ObjectStringConvertible {
    let filter: ItinerariesFilterInput?
    let options: ItinerariesOptionsInput?
    let search: SearchOnewayInput?
    
    public init(filter: ItinerariesFilterInput?,
                options: ItinerariesOptionsInput?,
                search: SearchOnewayInput?) {
        self.filter = filter
        self.options = options
        self.search = search
    }
}

extension OnewayFlightSearchParameters {
    public struct CabinClass: ObjectStringConvertible {
        let applyMixedClasses: Bool?
        let cabinClass: String?
        
        public init(applyMixedClasses: Bool? = nil, cabinClass: String? = nil) {
            self.applyMixedClasses = applyMixedClasses
            self.cabinClass = cabinClass
        }
    }

    public struct ItineraryLocation: ObjectStringConvertible {
        let ids: [String]?
        
        public init(ids: [String]? = nil) {
            self.ids = ids
        }
    }

    public struct Itinerary: ObjectStringConvertible {
        let source: ItineraryLocation
        let destination: ItineraryLocation
        let outboundDepartureDate: DateRange
        
        public init(source: OnewayFlightSearchParameters.ItineraryLocation,
                    destination: OnewayFlightSearchParameters.ItineraryLocation,
                    outboundDepartureDate: OnewayFlightSearchParameters.DateRange) {
            self.source = source
            self.destination = destination
            self.outboundDepartureDate = outboundDepartureDate
        }
    }

    public struct DateRange: ObjectStringConvertible {
        let start: String?
        let end: String?
        
        public init(start: String? = nil, end: String? = nil) {
            self.start = start
            self.end = end
        }
    }
}
