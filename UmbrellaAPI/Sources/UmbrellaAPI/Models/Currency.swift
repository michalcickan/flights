import Foundation

public struct Currency: Decodable {
    @ID
    private(set) public var id: String?
    public let code: String?
    public let name: String?
    public let format: CurrencyFormat?
    @Indirect
    public var currencyFallback: Currency?
    public let rate: String?
}
