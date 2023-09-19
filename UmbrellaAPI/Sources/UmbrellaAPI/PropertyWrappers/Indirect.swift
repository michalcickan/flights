@propertyWrapper
public enum Indirect<T: Decodable>: Decodable {
    indirect case next(T)
    
    public init(wrappedValue: T) {
        self = .next(wrappedValue)
    }
    
    public init(from decoder: Decoder) throws {
        self = .next(try T(from: decoder))
    }
    
    public var wrappedValue: T {
        switch self {
        case .next(let value): return value
        }
    }
}
