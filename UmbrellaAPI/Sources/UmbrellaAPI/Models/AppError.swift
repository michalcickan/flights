import Foundation

public struct AppError: Decodable, Error {
    public let message: String
    public let code: Int
}
