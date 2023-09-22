public struct BookingOption: Decodable {
    public let itineraryProvider: ItineraryProvider?
    public let price: Money?
    public let token: String?
    public let bookingUrl: String?
    public let trackingPixel: String?
    public let loyaltyPointTiers: LoyaltyPointTiers?
}
