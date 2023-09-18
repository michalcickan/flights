import Foundation
import XCTest

@testable import UmbrellaAPI

final class PropertyWrapperTests: XCTestCase {
    func testResultWithErrorWrapper_shouldThrowError_whenAppErrorPresent() {
        let expectedMessge = "Test"
        let response = """
        {
               "data": { "error": {
                    "message": "\(expectedMessge)",
                    "code": 2
                }
            }
        }
        """
        
        let data = response.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(APIResponse.self, from: data)) { error in
            XCTAssertEqual((error as? AppError)?.message, expectedMessge)
        }
    }
}
