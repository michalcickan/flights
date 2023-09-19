import Foundation

public struct ItinerariesOptionsInput: ObjectStringConvertible {
    enum SortBy: String, SimpleValueStringConvertible {
        case quality = "QUALITY"
    }
    
    let currency: String?
    let partner: String?
    let sortBy: SortBy?
    let sortOrder: SortOrderInput?
    let sortVersion: Int?
    let storeSearch: Bool?
}
