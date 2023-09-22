public struct Station: Decodable {
    private(set) public var id: String?
    public let name: String?
    public let slug: String?
    public let slugEn: String?
    public let code: String?
    public let city: City?
    public let country: Country?
    public let type: StationType?
    public let gps: GPS?
    public let rank: Int?
    public let icao: String?
    public let timezone: String?
}
