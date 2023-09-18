import Foundation


public actor Client {
    private let baseURL: URL
    
    public init(baseURL: String) throws {
        guard let baseURL = URL(string: baseURL) else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        self.baseURL = baseURL
    }
}

extension Client {
    func fetch(query: RootQuery, queryName: String) async throws -> RootResponse {
        var urlRequest = self.urlRequest
        urlRequest.httpBody = try JSONSerialization.data(
            withJSONObject: [
                "query": "query \(queryName) { \(query.stringValue) }"
            ]
        )
        let response = try await URLSession.shared.data(for: urlRequest)
        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.0)
        return apiResponse.data
    }
}

fileprivate extension Client {
    var urlRequest: URLRequest {
        var request = URLRequest(url: baseURL)
        request.setMethod(.post)
        request.setHeaderField(.accept(content: .json))
        request.setHeaderField(.contentType(content: .json))
        return request
    }
}

fileprivate extension URLRequest {
    mutating func setHeaderField(_ field: HeaderField) {
        switch field {
        case let .accept(content):
            setValue(content.rawValue, forHTTPHeaderField: "Accept")
        case let .contentType(content):
            setValue(content.rawValue, forHTTPHeaderField: "Content-Type")
        }
    }
    
    mutating func setMethod(_ method: Method) {
        self.httpMethod = method.rawValue
    }
}
