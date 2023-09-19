import Foundation

public protocol DataProvider {
    func rootReponse(for request: URLRequest) async throws -> RootResponse
}

extension URLSession: DataProvider {
    public func rootReponse(for request: URLRequest) async throws -> RootResponse {
        let response = try await data(for: request)
        return try JSONDecoder().decode(
            APIResponse.self,
            from: response.0
        ).data
    }
}
