import Foundation

public struct PlaceConnection: Decodable {
    public let pageInfo: PageInfo?
    public let edges: [PlaceEdge]?
}
