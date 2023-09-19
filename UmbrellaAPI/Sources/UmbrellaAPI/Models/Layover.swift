import Foundation

public struct Layover: Decodable {
    private(set) public var id: String?
    public let duration: Int?
    public let isStationChange: Bool?
    public let isBaggageRecheck: Bool?
    public let isWalkingDistance: Bool?
    public let transferDuration: Int?
    public let transferType: TransferType?
}
