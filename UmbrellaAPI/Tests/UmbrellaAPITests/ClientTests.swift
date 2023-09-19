import Foundation
import XCTest

@testable import UmbrellaAPI

final class ClientTests: XCTestCase {
    
    func testResultWithErrorWrapper_callsQuery_whenDataPresent() async {
        let client = try! Client(
            baseURL: "https://api.skypicker.com/umbrella/v2/graphql",
            dataProvider: MockDataProvider { _ in
                RootResponse()
            }
        )
        var called = false
        _ = try? await client.fetch(
            query: MockQuery(
                onGetModel: {
                    called = true
                    return $0
                }
            )
        )
        XCTAssertTrue(called)
    }
    
    func testResultWithErrorWrapper_shouldGiveResult_whenDataPresent() async {
        let placeConnection = PlaceConnection(
            pageInfo: nil,
            edges: nil
        )
        
        let client = try! Client(
            baseURL: "https://api.skypicker.com/umbrella/v2/graphql",
            dataProvider: MockDataProvider { _ in
                RootResponse(places: placeConnection)
            }
        )
        let result = try? await client.fetch(
            query: MockQuery<PlaceConnection>(
                onGetModel: { _ in placeConnection }
            )
        )
        XCTAssertNotNil(result)
    }
}
