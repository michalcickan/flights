import Foundation

public struct CityRadius: Decodable {
    @ID
    private(set) public var id: String?
    public let slug: String?
    public let radius: Radius?
    public let cities: [CityConnection]?
}
