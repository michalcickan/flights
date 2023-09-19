import Foundation

public struct ItinerariesFilterInput {
    let allowChangeInboundSource: Bool?
    let allowChangeInboundDestination: Bool?
    let allowDifferentStationConnection: Bool?
    let allowOvernightStopover: Bool?
    let contentProviders: [ItineraryContentProvider]?
    let limit: Int?
    let showNoCheckedBags: Bool?
    let transportTypes: [TransportType]?
    
    enum ItineraryContentProvider: String, ParametersStringConvertible {
        case amadeus = "AMADEUS"
        case aviasales = "AVIASALES"
        case busbud = "BUSBUD"
        case flixBusDirects = "FLIXBUS_DIRECTS"
        case fresh = "FRESH"
        case kayak = "KAYAK"
        case kiwi = "KIWI"
        case ndc = "NDC"
        case lastminute = "LASTMINUTE"
        case etraveli = "ETRAVELI"
        
    }
    
    enum TransportType: String, ParametersStringConvertible {
        case bus = "BUS"
        case flight = "FLIGHT"
        case train = "TRAIN"
    }
}
