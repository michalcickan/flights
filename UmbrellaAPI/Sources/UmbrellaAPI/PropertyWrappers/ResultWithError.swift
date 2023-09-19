import Foundation

@propertyWrapper
struct ResultWithError<T: Decodable>: Decodable {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    init(from decoder: Decoder) throws {
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
