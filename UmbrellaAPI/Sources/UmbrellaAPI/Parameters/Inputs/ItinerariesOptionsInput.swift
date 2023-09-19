import Foundation

public struct ItinerariesOptionsInput: ParametersStringConvertible {
    enum SortBy: String {
        case quality = "QUALITY"
    }
    
    let currency: String?
    let partner: String?
    let sortBy: SortBy?
    let sortOrder: SortOrderInput?
    let sortVersion: Int?
    let storeSearch: Bool?
}
