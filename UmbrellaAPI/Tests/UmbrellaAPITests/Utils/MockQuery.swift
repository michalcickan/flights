import Foundation

@testable import UmbrellaAPI

struct MockQuery<T: Decodable>: Query {
    typealias Model = T
    
    var queryModel: QueryModel { QueryModel(query: "") }
    let onGetModel: (RootResponse) throws -> T
    
    func extractModel(from rootResponse: RootResponse) throws -> T {
        try onGetModel(rootResponse)
    }
}

struct MockModel: Decodable {
    let a: String
}
