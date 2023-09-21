import Foundation
import UmbrellaAPI

protocol FilterOptionsServiceType {
    func fetchLocations(parameters: PlacesQueryParameters) async throws -> PlaceConnection
}

struct  FilterOptionsService:  FilterOptionsServiceType {
    let client: any APIClient
    
    func fetchLocations(parameters: PlacesQueryParameters) async throws -> PlaceConnection {
        try await client.fetch(
            query: PlacesQuery(
                parameters: parameters
            )
        )
    }
}
