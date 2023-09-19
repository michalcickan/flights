import Foundation

public struct RootResponse: Decodable {
    public let places: PlaceConnection?
    public let onewayItineraries: OnewayItineraries?
    
    init(places: PlaceConnection? = nil,
         onewayItineraries: OnewayItineraries? = nil) {
        self.places = places
        self.onewayItineraries = onewayItineraries
    }
}
