import Foundation

public struct SearchOnewayInput: ObjectStringConvertible {
    let cabinClass: CabinClassInput?
    let itinerary: ItineraryOnewayInput?
    let passengers: PassengersInput?
    
    public init(cabinClass: CabinClassInput? = nil,
                itinerary: ItineraryOnewayInput? = nil,
                passengers: PassengersInput? = nil) {
        self.cabinClass = cabinClass
        self.itinerary = itinerary
        self.passengers = passengers
    }
}

extension SearchOnewayInput {
    public struct PassengersInput: ObjectStringConvertible {
        let adults: Int?
        let adultsHandBags: [Int]?
        let adultsHoldBags: [Int]?
        
        public init(adults: Int? = nil,
                    adultsHandBags: [Int]? = nil,
                    adultsHoldBags: [Int]? = nil) {
            self.adults = adults
            self.adultsHandBags = adultsHandBags
            self.adultsHoldBags = adultsHoldBags
        }
    }

    public struct CabinClassInput: ObjectStringConvertible {
        let applyMixedClasses: Bool?
        let cabinClass: CabinClassType?
        
        public init(applyMixedClasses: Bool?, cabinClass: CabinClassType?) {
            self.applyMixedClasses = applyMixedClasses
            self.cabinClass = cabinClass
        }
    }

    public struct ItineraryLocation: ObjectStringConvertible {
        let ids: [String]?
        
        public init(ids: [String]?) {
            self.ids = ids
        }
    }

    public struct ItineraryOnewayInput: ObjectStringConvertible {
        let source: ItineraryLocation
        let destination: ItineraryLocation
        let outboundDepartureDate: DateRange
        
        public init(source: ItineraryLocation, destination: ItineraryLocation, outboundDepartureDate: DateRange) {
            self.source = source
            self.destination = destination
            self.outboundDepartureDate = outboundDepartureDate
        }
    }

    public struct DateRange: ObjectStringConvertible {
        @DateTransformer
        var start: Date?
        @DateTransformer
        var end: Date?
        
        public init(start: Date? = nil, end: Date? = nil) {
            _start = DateTransformer(date: start)
            _end = DateTransformer(date: end)
        }
    }
}
