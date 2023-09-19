public struct Sector: Decodable {
    @ID
    private(set) public var id: String?
    let sectorSegments: [SectorSegment]?
    let carriers: [Carrier]?
    let duration: Int?
}
