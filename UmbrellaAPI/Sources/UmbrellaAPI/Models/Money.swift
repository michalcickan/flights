import Foundation

public struct Money: Decodable {
    public let amount: String?
    public let roundedAmount: String?
    public let currency: Currency?
    public let formattedValue: String?
    public let roundedFormattedValue: String?
    public let priceBeforeDiscount: String?
    public let priceBeforeDiscountFormatted: String?
}
