import UmbrellaAPI

struct PersistentFilter {
    var sources: Array<String>?
    var destinations: Array<String>?
    var cabinClassType: CabinClassType?
    var sortBy: ItinerariesOptionsInput.SortBy?
    var numberOfAdults: Int?
    var adultsHoldBags: [Int]?
    
    init(sources: Array<String>? = nil,
         destinations: Array<String>? = nil,
         cabinClassType: CabinClassType? = nil,
         sortBy: ItinerariesOptionsInput.SortBy? = nil,
         numberOfAdults: Int? = nil,
         adultsHoldBags: [Int]? = nil) {
        self.sources = sources
        self.destinations = destinations
        self.cabinClassType = cabinClassType
        self.sortBy = sortBy
        self.numberOfAdults = numberOfAdults
        self.adultsHoldBags = adultsHoldBags
    }
}

extension PersistentFilter {
    mutating func copyWith(sources: Array<String>? = nil,
                           destinations: Array<String>? = nil,
                           cabinClassType: CabinClassType? = nil,
                           sortBy: ItinerariesOptionsInput.SortBy? = nil,
                           numberOfAdults: Int? = nil,
                           adultsHoldBags: [Int]? = nil) -> PersistentFilter {
        PersistentFilter(
            sources: sources ?? self.sources,
            destinations: destinations ?? self.destinations,
            cabinClassType: cabinClassType ?? self.cabinClassType,
            sortBy: sortBy ?? self.sortBy,
            numberOfAdults: numberOfAdults ?? self.numberOfAdults,
            adultsHoldBags: adultsHoldBags ?? self.adultsHoldBags
        )
    }
}
