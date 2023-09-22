public struct Continent: Decodable {
    @ID
    private(set) public var id: String?
    public let legacyId: String?
    public let name: String?
    public let slug: String?
    public let slugEn: String?
    public let gps: GPS?
    public let rank: Int?
    public let cities: [City]?
}
