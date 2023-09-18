import Foundation
import XCTest

@testable import UmbrellaAPI

final class ClientTests: XCTestCase {
    func testResultWithErrorWrapper_shouldThrowError_whenAppErrorPresent() async {
        let client = try! Client(baseURL: "https://api.skypicker.com/umbrella/v2/graphql")
        let result = try? await client.fetchPlacesNodes(
            params: PlacesQueryParameters(
                search: PlacesQueryParameters.Search(term: "pov"),
                filter: PlacesQueryParameters.Filter(
                    onlyTypes: [.airport, .city],
                    groupByCity: true
                ),
                options: PlacesQueryParameters.Options(sortBy: .rank),
                first: 10
            )
        )
        XCTAssertEqual(result?.edges?.count, 10)
    }
}
