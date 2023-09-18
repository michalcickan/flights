import Foundation

@propertyWrapper
public struct ResultWithError<T: Decodable>: Decodable {
    public var wrappedValue: T
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        guard let source = try? T(from: decoder) else {
            let containter = try decoder.container(keyedBy: CodingKeys.self)
            let error = try containter.decode(AppError.self, forKey: .error)
            throw error
        }
        self.wrappedValue = source
    }
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}
