import Foundation

public struct OnewayItineraries: Decodable {
//    public let server: Server
//    public let metadata: ItinerariesMetadata
    public let itineraries: [Itinerary]
}
