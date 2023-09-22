public struct Sector: Decodable {
    @ID
    private(set) public var id: String?
    public let sectorSegments: [SectorSegment]?
    public let carriers: [Carrier]?
    public let duration: Int?
}
