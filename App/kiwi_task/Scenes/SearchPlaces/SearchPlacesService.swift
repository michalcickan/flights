import Foundation
import UmbrellaAPI

protocol SearchPlacesServiceType {
    func searchPlaces(parameters: PlacesQueryParameters) async throws -> [PlaceEdge]
}

struct SearchPlacesService: SearchPlacesServiceType {
    let apiClient: any APIClient
    
    func searchPlaces(parameters: PlacesQueryParameters) async throws -> [PlaceEdge] {
        (try await apiClient.fetch(query: PlacesQuery(parameters: parameters)))
            .edges ?? []
    }
}
