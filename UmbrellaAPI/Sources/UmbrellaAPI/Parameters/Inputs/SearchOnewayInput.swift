import Foundation

public struct SearchOnewayInput: ObjectStringConvertible {
    let cabinClass: CabinClassInput?
    let itinerary: ItineraryOnewayInput?
    let passengers: PassengersInput?
}

extension SearchOnewayInput {
    public struct PassengersInput: ObjectStringConvertible {
        let adults: Int?
        let adultsHandBags: [Int]?
        let adultsHoldBags: [Int]?
    }

    public struct CabinClassInput: ObjectStringConvertible {
        let applyMixedClasses: Bool?
        let cabinClass: CabinClassType?
    }

    public struct ItineraryLocation: ObjectStringConvertible {
        let ids: [String]?
    }

    public struct ItineraryOnewayInput: ObjectStringConvertible {
        let source: ItineraryLocation
        let destination: ItineraryLocation
        let outboundDepartureDate: DateRange
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
