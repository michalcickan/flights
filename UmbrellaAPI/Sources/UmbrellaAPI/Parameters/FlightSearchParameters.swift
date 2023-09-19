import Foundation

public struct FlightSearchParameters: ParametersStringConvertible {
    let filter: ItinerariesFilterInput?
    let options: ItinerariesOptionsInput?
    let search: SearchOnewayInput?
}

extension FlightSearchParameters {    
    public struct SearchPassengers: ParametersStringConvertible {
        let adults: Int?
        let adultsHandBags: [Int]?
        let adultsHoldBags: [Int]?
    }

    public struct CabinClass: ParametersStringConvertible {
        let applyMixedClasses: Bool?
        let cabinClass: String?
    }

    public struct ItineraryLocation: ParametersStringConvertible {
        let ids: [String]?
    }

    public struct Itinerary: ParametersStringConvertible {
        let source: ItineraryLocation
        let destination: ItineraryLocation
        let outboundDepartureDate: DateRange
    }

    public struct DateRange: ParametersStringConvertible {
        let start: String?
        let end: String?
    }
}
