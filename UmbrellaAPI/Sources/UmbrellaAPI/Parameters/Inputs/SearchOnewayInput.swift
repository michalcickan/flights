import Foundation

public struct SearchOnewayInput: ParametersStringConvertible {
    let cabinClass: CabinClassInput?
    let itinerary: ItineraryOnewayInput?
    let passengers: PassengersInput?
}

extension SearchOnewayInput {
    public struct PassengersInput: ParametersStringConvertible {
        let adults: Int?
        let adultsHandBags: [Int]?
        let adultsHoldBags: [Int]?
    }

    public struct CabinClassInput: ParametersStringConvertible {
        let applyMixedClasses: Bool?
        let cabinClass: CabinClassType?
    }

    public struct ItineraryLocation: ParametersStringConvertible {
        let ids: [String]?
    }

    public struct ItineraryOnewayInput: ParametersStringConvertible {
        let source: ItineraryLocation
        let destination: ItineraryLocation
        let outboundDepartureDate: DateRange
    }

    public struct DateRange: ParametersStringConvertible {
        let start: String?
        let end: String?
    }
}
