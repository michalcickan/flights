import Foundation

public struct ItineraryProvider: Decodable {
    @ID
    private(set) public var id: String?
    public let name: String?
    public let code: String?
    public let subprovider: String?
    public let contentProvider: ContentProvider
    public let hasHighProbabilityOfPriceChange: Bool?
}
