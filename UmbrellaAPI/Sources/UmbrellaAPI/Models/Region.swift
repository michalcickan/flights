public struct Region: Decodable {
    @ID
    private(set) public var id: String?
    public let legacyId: String?
    public let name: String?
    public let slug: String?
    public let slugEn: String?
    public let continent: Continent?
    public let cities: [City]
    //    (?
    //public let first: Int?
    //public let sort: PlacesSortByInput?
    //): [City]
    public let gps: GPS
    public let rank: Int
}
