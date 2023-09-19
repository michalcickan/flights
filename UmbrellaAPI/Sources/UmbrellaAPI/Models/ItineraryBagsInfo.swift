public struct ItineraryBagsInfo: Decodable {
    public let checkedBagTiers: [BaggageTier]?
    public let handBagTiers: [BaggageTier]?
    public let personalItemTiers: [BaggageTier]?
    public let includedHandBags: Int?
    public let includedCheckedBags: Int?
    public let includedPersonalItem: Int?
    public let hasNoBaggageSupported: Bool?
    public let hasNoCheckedBaggage: Bool?
}
