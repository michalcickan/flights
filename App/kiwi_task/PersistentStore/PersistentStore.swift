import Foundation
import UmbrellaAPI

// Cannot insert protocol as environment object
open class PersistenStore: ObservableObject {
    var places: [PersistentPlace]?
    var filter: PersistentFilter?
    
    init(places: [PersistentPlace]? = nil, filter: PersistentFilter? = nil) {
     fatalError("Need to subclass")
    }
}

struct PersistentFilter {
    let sources: Array<String>?
    let destinations: Array<String>?
    let cabinClassType: CabinClassType?
    let sortBy: ItinerariesOptionsInput.SortBy?
    let numberOfAdults: Int?
    let adultsHoldBags: [Int]?
}

struct PersistentPlace {
    let imageUrl: String?
    let id: String
    let lat: Double
    let lng: Double
}
