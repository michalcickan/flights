public struct Carrier: Decodable {
    @ID
    private(set) public var id: String?
    public let name: String?
    public let slug: String?
    public let code: String?
    public let logo: Image?
    public let icao: String?
    public let country: Country?
    public let alliance: String?
    public let website: String?
    public let checkInInfo: CheckInInfo?
    public let deprecated: Bool?
    public let closeBookingHours: Int?
    public let allowedBookingWindow: IntervalRange?
    public let bookingDocNeeded: BookingDocNeededOption?
    public let childrenAgeThreshold: Int?
    public let teenAgeThreshold: Int?
    public let adultAgeThreshold: Int?
}
