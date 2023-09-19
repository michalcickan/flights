public struct City: Decodable {
    @ID
    private(set) public var id: String?
    public let legacyId: String
    public let mapId: String?
    public let name: String
    public let slug: String
    public let code: String
    public let slugEn: String
    public let stations: StationConnection
    public let first: Int?
    public let last: Int?
    public let before: String?
    public let after: String?
    public let nearbyCities: CityRadius?
    public let photo: Image?
    public let country: Country?
    public let region: Region?
    //    public let autonomousTerritory: AutonomousTerritory?
    //    public let subdivision: Subdivision?
    public let gps: GPS?
    public let rank: Int?
    public let timezone: String?
    public let airportsCount: Int?
    public let groundStationsCount: Int?
    public let tags: [String]?
}
