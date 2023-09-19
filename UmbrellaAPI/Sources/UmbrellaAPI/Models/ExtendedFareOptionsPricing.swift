import Foundation

public struct ExtendedFareOptionsPricing: Decodable {
    public let standardFarePrice: Money?
    public let flexiFarePrice: Money?
}
