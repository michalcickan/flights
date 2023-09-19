import Foundation

@testable import UmbrellaAPI

struct MockDataProvider: DataProvider {
    let onData: (URLRequest) -> RootResponse
    
    func rootReponse(for request: URLRequest) async throws -> RootResponse {
        return onData(request)
    }
}
