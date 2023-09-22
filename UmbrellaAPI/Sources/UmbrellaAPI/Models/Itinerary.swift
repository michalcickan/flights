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
    public let sector: Sector?
    public let highlights: Highlights?
    
    public init(id: String? = nil,
                shareId: String? = nil,
                price: Money? = nil,
                priceEur: Money? = nil,
                extendedFareOptionsPricing: ExtendedFareOptionsPricing? = nil,
                paidGuaranteePrice: Money? = nil,
                duration: Int? = nil,
                provider: ItineraryProvider? = nil,
                bookingOptions: BookingOptionConnection? = nil,
                bagsInfo: ItineraryBagsInfo? = nil,
                cabinClasses: [CabinClassType]? = nil,
                loyaltyPointTiers: LoyaltyPointTiers? = nil,
                technicalStops: Int? = nil,
                isTravelHack: Bool? = nil,
                travelHack: TravelHack? = nil,
                sector: Sector? = nil,
                highlights: Highlights? = nil) {
        self.id = id
        self.shareId = shareId
        self.price = price
        self.priceEur = priceEur
        self.extendedFareOptionsPricing = extendedFareOptionsPricing
        self.paidGuaranteePrice = paidGuaranteePrice
        self.duration = duration
        self.provider = provider
        self.bookingOptions = bookingOptions
        self.bagsInfo = bagsInfo
        self.cabinClasses = cabinClasses
        self.loyaltyPointTiers = loyaltyPointTiers
        self.technicalStops = technicalStops
        self.isTravelHack = isTravelHack
        self.travelHack = travelHack
        self.sector = sector
        self.highlights = highlights
    }
}
