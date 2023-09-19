import Foundation

@propertyWrapper
struct ResultWithError<T: Decodable>: Decodable {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    init(from decoder: Decoder) throws {
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        if let error = try? containter.decode(AppError.self, forKey: .error) {
            throw error
        }
        self.wrappedValue = try T(from: decoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}
