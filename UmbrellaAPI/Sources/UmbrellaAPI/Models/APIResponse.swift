import Foundation

struct APIResponse: Decodable {
    @ResultWithError
    var data: RootResponse
}
