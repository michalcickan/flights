import Foundation

public struct Place: Decodable {
    @ID
    private(set) public var id: String?
    public let legacyId: String?
    public let name: String?
    public let gps: GPS?
    public let slugEn: String?
    public let rank: Int?
}
