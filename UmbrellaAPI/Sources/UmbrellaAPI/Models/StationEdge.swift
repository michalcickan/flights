public struct StationEdge: Decodable {
    public let node: Station?
    public let cursor: String?
    // Driving distance from parent place.
    public let carDirections: CarDirections?
    
    // GPS distance from parent place.
    public let sphericalDistance: Distance?
    
}
