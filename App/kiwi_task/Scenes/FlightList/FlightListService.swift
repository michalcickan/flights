import Foundation
import UmbrellaAPI

protocol FlightListServiceType {
    func fetchOnewayFlights(parameters: OnewayFlightSearchParameters) async throws -> OnewayItineraries
}

struct FlightListService: FlightListServiceType {
    let client: any APIClient
    
    func fetchOnewayFlights(parameters: OnewayFlightSearchParameters) async throws -> OnewayItineraries {
        try await client.fetch(query: FlightsQuery(parameters: parameters))
    }
}
