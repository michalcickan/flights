import Foundation

public struct TravelRestriction: Decodable {
    public let country: Country?
    public let restricted: TravelRestricted?
    public let restrictions: [String]?
    @DateTransformer
    private(set) public var published: Date?
}
