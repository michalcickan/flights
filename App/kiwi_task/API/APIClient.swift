import Foundation
import UmbrellaAPI

protocol APIClient: ObservableObject {
    func fetch<T: Query>(query: T) async throws -> T.Model
}

extension Client: APIClient { }

extension Client: ObservableObject { }

final class PreviewAPIClient: ObservableObject, APIClient {
    public func fetch<T: Query>(query: T) async throws -> T.Model {
        var urlRequest = URLRequest(url: URL(string: "http://localhost:8080")!)
        urlRequest.httpBody = try JSONEncoder().encode(query.queryModel)
        return try query.extractModel(
            from: try await URLSession.shared.rootReponse(for: urlRequest)
        )
    }
}
