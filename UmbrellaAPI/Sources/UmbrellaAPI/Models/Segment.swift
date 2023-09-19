public struct Segment: Decodable {
    @ID
    private(set) public var id: String?
    public let source: Stop?
    public let destination: Stop?
    public let duration: Int?
    public let type: TransportType?
    public let code: String?
    public let carrier: Carrier?
    public let operatingCarrier: Carrier?
    public let cabinClass: CabinClassType?
    public let travelRestrictions: [TravelRestriction]?
    /// True Hidden City destination, available only for last segment of the combination that ends in a different station.
    public let hiddenDestination: Station?
    public let throwawayDestination: Station?
    public let followingTechnicalStop: Bool?
}
