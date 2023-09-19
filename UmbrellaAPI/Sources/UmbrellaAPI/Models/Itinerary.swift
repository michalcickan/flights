import Foundation

public struct Itinerary: Decodable {
    public let id: String?
    public let shareId: String?
    public let price: Money?
    public let priceEur: Money?
    public let extendedFareOptionsPricing: ExtendedFareOptionsPricing?
    public let paidGuaranteePrice: Money?
    public let duration: Int?
    public let provider: ItineraryProvider?
    public let bookingOptions: BookingOptionConnection?
    public let bagsInfo: ItineraryBagsInfo?
    public let cabinClasses: [CabinClassType]?
    public let loyaltyPointTiers: LoyaltyPointTiers?
    public let technicalStops: Int?
    public let isTravelHack: Bool?
    public let travelHack: TravelHack?
    public let highlights: Highlights?
}
