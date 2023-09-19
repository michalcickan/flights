public struct PageInfo: Decodable {
    public let hasNextPage: Bool?
    public let hasPreviousPage: Bool?
    public let startCursor: String?
    public let endCursor: String?
}
