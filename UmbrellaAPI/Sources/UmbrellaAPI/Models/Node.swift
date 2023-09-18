import Foundation

public struct Node: Decodable {
    public let id: String
    public let legacyId: String
    public let name: String?
    public let gps: GPS?
    public let slugEn: String?
    public let rank: Int?
}
