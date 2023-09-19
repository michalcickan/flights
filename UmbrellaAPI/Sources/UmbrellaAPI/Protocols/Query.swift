import Foundation

public struct QueryModel: Encodable, Equatable {
    let query: String
    //    let fragments: [String: String]?
    
    public init(query: String) {
        //                fragments: [String: String]? = nil) {
        
        self.query = query
        //        self.fragments = fragments
    }
}

public protocol Query {
    associatedtype Model: Decodable
    
    var queryModel: QueryModel { get }
    func extractModel(from rootResponse: RootResponse) throws -> Model
}

extension Query {
    func gqlParametersOrEmpty(from parameters: ObjectStringConvertible?) -> String {
        guard let parameters else {
            return ""
        }
        return "(\(parameters.stringValue))"
    }
    
    func unwrapOrThrow(_ model: Model?) throws -> Model {
        guard let model else {
            throw ValidationException.parsing
        }
        return model
    }
}
