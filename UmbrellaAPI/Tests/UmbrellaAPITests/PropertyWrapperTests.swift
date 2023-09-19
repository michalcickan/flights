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
    
    func testDateTrasformer_shouldParse_whenUnixTimePresent() {
        let currentDate = Date()
        let stringDate = testDateFormatter.string(from: currentDate)
        let json = """
            {
                "date": "\(stringDate)"
            }
            """
        let model = try! JSONDecoder().decode(
            MockDateTransformer.self,
            from: json.data(using: .utf8)!
        )
        // Avoid comparing Date, since timestamp is not equal due to converting from string
        XCTAssertEqual(
            testDateFormatter.string(from: model.date ?? Date()),
            stringDate
        )
    }
}


struct MockDateTransformer: Codable {
    @DateTransformer
    var date: Date?
}
