import Foundation

public struct FlightsQuery {
    private let parameters: OneWayFlightSearchParameters?
    
    public init(parameters: OneWayFlightSearchParameters?) {
        self.parameters = parameters
    }
}

extension FlightsQuery: Query {
    public typealias Model = OnewayItineraries
    
    public var queryModel: QueryModel {
        QueryModel(
            query:
        """
        fragment stopDetails on Stop {
            utcTime
            localTime
            station { id name code type city { id legacyId name country { id name } } }
        }
        
         query onewayItineraries {
           onewayItineraries\(gqlParametersOrEmpty(from: parameters))
        {
         ... on Itineraries {
               itineraries {
                 ... on ItineraryOneWay {
                   id duration cabinClasses priceEur { amount }
                   bookingOptions {
         edges {
                       node { bookingUrl price { amount formattedValue } }
                     }
                   }
                   provider { id name code }
                   sector {
                     id duration
                     sectorSegments {
                       segment {
                         id duration type code
                         source { ...stopDetails }
                         destination { ...stopDetails }
                         carrier { id name code }
                         operatingCarrier { id name code }
                       }
                       layover { duration isBaggageRecheck transferDuration transferType }
                       guarantee
         } }
         } }
         } }
         }
        """
        )
    }
    
    public func extractModel(from rootResponse: RootResponse) throws -> Model {
        try unwrapOrThrow(rootResponse.onewayItineraries)
    }
}
