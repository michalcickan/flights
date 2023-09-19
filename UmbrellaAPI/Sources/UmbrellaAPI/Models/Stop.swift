import Foundation

public struct Stop: Decodable {
    /// The location of the stop. It can be an airport, bus station, train station, etc.
    public let station: Station?
    /// Local date and time of arrival to a specific station. It should correspond to the UTC time.
    @DateTransformer
    private(set) public var localTime: Date?
    /// UTC date and time of arrival to a specific station. It should correspond to the local time.
    @DateTransformer
    private(set) public var utcTime: Date?
}
