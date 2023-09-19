import Foundation

private let dateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter
}()

@propertyWrapper
public struct DateTransformer: Codable {
    public var wrappedValue: Date?
    
    init(date: String) {
        self.wrappedValue = dateFormatter.date(from: date)
    }
    
    public init(from decoder: Decoder) throws {
        let source = try String(from: decoder)
        wrappedValue = dateFormatter.date(from: source)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        guard let date = wrappedValue else {
            try container.encodeNil()
            return
        }
        try container.encode(dateFormatter.string(from: date))
    }
}
