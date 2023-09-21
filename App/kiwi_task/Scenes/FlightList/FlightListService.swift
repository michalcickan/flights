import Foundation
import UmbrellaAPI

protocol FlightListServiceType {
    
}

struct FlightListService:  FlightListServiceType {
    let client: any APIClient
}
