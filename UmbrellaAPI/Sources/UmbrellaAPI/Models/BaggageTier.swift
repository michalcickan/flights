public struct BaggageTier: Decodable {
    public let tierPrice: Money?
    public let bags: [BaggageInfo]?
}
