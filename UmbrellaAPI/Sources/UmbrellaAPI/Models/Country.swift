public struct Country: Decodable {
    @ID
    private(set) public var id: String?
    public let legacyId: String
    public let code: String?
    public let name: String
    public let slug: String
    public let slugEn: String?
    public let region: Region?
    public let neighbourCountries: [Country]?
    public let cities: [City]?
    public let gps: GPS?
    public let rank: Int?
    @Indirect
    public var majorCity: City?
}
