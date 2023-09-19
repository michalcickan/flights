import Foundation

public struct PlacesQuery {
    private let parameters: PlacesQueryParameters?
    
    public init(parameters: PlacesQueryParameters?) {
        self.parameters = parameters
    }
}

extension PlacesQuery: Query {
    public typealias Model = PlaceConnection
    
    public var queryModel: QueryModel {
        QueryModel(
            query: """
         query places {
                places\(gqlParametersOrEmpty(from: parameters)) {
        ... on PlaceConnection {
                        edges { node { id legacyId name gps { lat lng } } }
                    }
        } }
        """
        )
    }
    
    public func extractModel(from rootResponse: RootResponse) throws -> Model {
        try unwrapOrThrow(rootResponse.places)
    }
}
