import Foundation

public struct RootResponse: Decodable {
    public let places: PlaceConnection
    public let onewayItineraries: OnewayItineraries
}
