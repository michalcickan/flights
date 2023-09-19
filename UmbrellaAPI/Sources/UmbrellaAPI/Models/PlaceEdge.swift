import Foundation

public struct PlaceEdge: Decodable {
    public let node: Place?
    public let rank: Int?
    public let isAmbiguous: Bool?
    public let cursor: String?
    public let distance: Distance?
}
