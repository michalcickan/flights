import Foundation

public struct SectorSegment: Decodable {
    public let segment: Segment?
    public let layover: Layover?
    public let guarantee: ItineraryGuaranteeType?
}
