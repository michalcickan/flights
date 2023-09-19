import Foundation

@propertyWrapper
public struct ID: Decodable {
    public var wrappedValue: String?
    
    public init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        guard let integer = try? Int(from: decoder) else {
            self.wrappedValue = try String(from: decoder)
            return
        }
        self.wrappedValue = String(integer)
    }
}
