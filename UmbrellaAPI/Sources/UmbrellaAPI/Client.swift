import Foundation

public actor Client {
    private let baseURL: URL
    private let dataProvider: DataProvider
    
    public init(baseURL: String,
                dataProvider: DataProvider = URLSession.shared) throws {
        guard let baseURL = URL(string: baseURL) else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        self.baseURL = baseURL
        self.dataProvider = dataProvider
    }
}

extension Client {
    public func fetch<T: Query>(query: T) async throws -> T.Model {
        var urlRequest = self.urlRequest
        urlRequest.httpBody = try JSONEncoder().encode(query.queryModel)
        return try query.extractModel(
            from: try await dataProvider.rootReponse(for: urlRequest)
        )
    }
}

private extension Client {
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
