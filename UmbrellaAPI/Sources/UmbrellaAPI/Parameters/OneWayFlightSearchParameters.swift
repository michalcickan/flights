import Foundation

public struct OneWayFlightSearchParameters: ObjectStringConvertible {
    let filter: ItinerariesFilterInput?
    let options: ItinerariesOptionsInput?
    let search: SearchOnewayInput?
}

extension OneWayFlightSearchParameters {    
    public struct SearchPassengers: ObjectStringConvertible {
        let adults: Int?
        let adultsHandBags: [Int]?
        let adultsHoldBags: [Int]?
    }

    public struct CabinClass: ObjectStringConvertible {
        let applyMixedClasses: Bool?
        let cabinClass: String?
    }

    public struct ItineraryLocation: ObjectStringConvertible {
        let ids: [String]?
    }

    public struct Itinerary: ObjectStringConvertible {
        let source: ItineraryLocation
        let destination: ItineraryLocation
        let outboundDepartureDate: DateRange
    }

    public struct DateRange: ObjectStringConvertible {
        let start: String?
        let end: String?
    }
}
