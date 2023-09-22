import Foundation

struct FlightCardViewModel: Identifiable, Hashable {
    static func == (lhs: FlightCardViewModel, rhs: FlightCardViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
    
    let id: String
    
    var imageUrl: URL?
    let formattedPrice: String
    let direction: String
    let numberOfStopOvers: String
    let duration: String
    let onTap: () -> Void
    
    init(id: String,
         legacyId: String?,
         formattedPrice: String,
         direction: String,
         numberOfStopOvers: Int,
         duration: Int,
         onTap: @escaping () -> Void) {
        self.id = id
        if let legacyId {
            imageUrl = URL(string: "\(Config.photoBaseUrl)/\(legacyId).jpg")
        }
        self.formattedPrice = formattedPrice
        self.direction = direction
        self.numberOfStopOvers = numberOfStopOvers > 0 ? "Stops \(numberOfStopOvers)" : "Direct"
        self.duration = duration.secondsToTime
        self.onTap = onTap
    }
}
