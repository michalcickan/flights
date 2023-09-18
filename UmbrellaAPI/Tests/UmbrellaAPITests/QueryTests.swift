import Foundation
import XCTest

@testable import UmbrellaAPI

final class QueryTests: XCTestCase {
    func testPlacesQuery() {
        let expectedQuery = """
        places (search:{term:"pov"},filter:{onlyTypes:[AIRPORT,CITY],groupByCity:true},options:{sortBy:RANK},first:20) {... on PlaceConnection {edges {node {id legacyId gps {lng lat}}}}}
        """
        
        let query = RootQuery(
            places: PlacesQuery(
                parameters: PlacesQueryParameters(
                    search: .init(term: "pov"),
                    filter: .init(
                        onlyTypes: [.airport, .city],
                        groupByCity: true
                    ),
                    options: .init(sortBy: .rank),
                    first: 20
                ),
                body: .init(
                    placeConnection: OnPlaceConnectionQuery(
                        body: .init(
                            edges: EdgesQuery(
                                body: .init(
                                    node: NodeQuery(
                                        body: .init(
                                            id: "",
                                            legacyId: "",
                                            gps: GPSQuery(
                                                body: .init(
                                                    lng: "",
                                                    lat: ""
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
        XCTAssertEqual(expectedQuery, query.stringValue)
    }
}
