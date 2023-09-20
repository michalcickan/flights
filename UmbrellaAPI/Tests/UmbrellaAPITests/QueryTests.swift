import Foundation
import XCTest

@testable import UmbrellaAPI

final class QueryTests: XCTestCase {
    func testPlacesQuery() {
        let expectedQuery = """
         query places {
                places(search:{term:"pov"},filter:{onlyTypes:[AIRPORT,CITY],groupByCity:true},options:{sortBy:RANK},first:20) {
        ... on PlaceConnection {
                        edges { node { id legacyId name gps { lat lng } } }
                    }
        } }
        """
        let query = PlacesQuery(
            parameters: PlacesQueryParameters(
                search: .init(term: "pov"),
                filter: .init(
                    onlyTypes: [.airport, .city],
                    groupByCity: true
                ),
                options: .init(sortBy: .rank),
                first: 20
            )
        )
        XCTAssertEqual(
            expectedQuery.normalizeQuery,
            query.queryModel.query.normalizeQuery
        )
    }
    
    func testFlightsQuery() {
        let startDate = Date()
        let endDate = Date().addingTimeInterval(60)
        let expectedQueryModel = QueryModel(
            query:
               """
               fragment stopDetails on Stop {
                   utcTime
                   localTime
                   station { id name code type city { id legacyId name country { id name } } }
               }
               
                query onewayItineraries {
                  onewayItineraries(filter:{allowChangeInboundSource:false,allowChangeInboundDestination:false,allowDifferentStationConnection:true,allowOvernightStopover:true,contentProviders:[KIWI],limit:10,showNoCheckedBags:true,transportTypes:[FLIGHT]},options:{currency:"EUR",partner:"skypicker",sortBy:QUALITY,sortOrder:ASCENDING,sortVersion:4,storeSearch:true},search:{cabinClass:{applyMixedClasses:true,cabinClass:ECONOMY},itinerary:{source:{ids:["City:brno_cz"]},destination:{ids:["City:new-york-city_ny_us"]},outboundDepartureDate:{start:"\(testDateFormatter.string(from: startDate))",end:"\(testDateFormatter.string(from: endDate))"}},passengers:{adults:1,adultsHandBags:[1],adultsHoldBags:[0]}})
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
        let query = FlightsQuery(
            parameters: parameters(startDate: startDate, endDate: endDate)
        )
        XCTAssertEqual(
            expectedQueryModel.query.normalizeQuery,
            query.queryModel.query.normalizeQuery
        )
    }
    
    func testFetchQuery_shouldReturnPlacesData_whenPresent() async {
        let client = try! Client(
            baseURL: "https://api.skypicker.com/umbrella/v2/graphql"
        )
        let result = try? await client.fetch(
            query: PlacesQuery(parameters: placeParameters())
        )
        XCTAssertNotNil(result)
    }
    
    func testFlightsQuery_shouldGiveData_whenDataPresent() async {
        let client = try! Client(
            baseURL: "https://api.skypicker.com/umbrella/v2/graphql"
        )
        let result = try? await client.fetch(
            query: FlightsQuery(parameters: parameters(startDate: Date(), endDate: Date().addingTimeInterval(120)))
        )
        XCTAssertNotNil(result)
    }
}

private func parameters(startDate: Date, endDate: Date) -> OnewayFlightSearchParameters {
    OnewayFlightSearchParameters(
        filter: .init(
            allowChangeInboundSource: false,
            allowChangeInboundDestination: false,
            allowDifferentStationConnection: true,
            allowOvernightStopover: true,
            contentProviders: [.kiwi],
            limit: 10,
            showNoCheckedBags: true,
            transportTypes: [.flight]
        ),
        options: .init(
            currency: "EUR",
            partner: "skypicker",
            sortBy: .quality,
            sortOrder: .asc,
            sortVersion: 4,
            storeSearch: true
        ),
        search: .init(
            cabinClass: .init(
                applyMixedClasses: true,
                cabinClass: .economy
            ),
            itinerary: .init(
                source: .init(ids: ["City:brno_cz"]),
                destination: .init(ids: ["City:new-york-city_ny_us"]),
                outboundDepartureDate: .init(
                    start: startDate,
                    end: endDate
                )
            ),
            passengers: .init(adults: 1, adultsHandBags: [1], adultsHoldBags: [0]))
    )
}

private func placeParameters() -> PlacesQueryParameters {
    PlacesQueryParameters(
        search: .init(term: "pov"),
        filter: .init(
            onlyTypes: [.airport, .city],
            groupByCity: true
        ),
        options: .init(sortBy: .rank),
        first: 20
    )
}

fileprivate extension String {
    var normalizeQuery: String {
        replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
}
