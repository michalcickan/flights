public struct ContentProvider: Decodable {
    @ID
    private(set) public var id: String?
    public let code: String?
    public let name: String?
    public let siteName: String?
}
