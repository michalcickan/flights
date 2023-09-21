import Foundation

public struct ItinerariesOptionsInput: ObjectStringConvertible {
    public enum SortBy: String, SimpleValueStringConvertible {
        case quality = "QUALITY"
    }
    
    let currency: String?
    let partner: String?
    let sortBy: SortBy?
    let sortOrder: SortOrderInput?
    let sortVersion: Int?
    let storeSearch: Bool?
    
    public init(currency: String? = nil,
                partner: String? = nil,
                sortBy: ItinerariesOptionsInput.SortBy? = nil,
                sortOrder: SortOrderInput? = nil,
                sortVersion: Int? = nil,
                storeSearch: Bool? = nil) {
        self.currency = currency
        self.partner = partner
        self.sortBy = sortBy
        self.sortOrder = sortOrder
        self.sortVersion = sortVersion
        self.storeSearch = storeSearch
    }
}
