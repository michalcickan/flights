import Foundation
import Orbit

struct CardViewModel: Identifiable, Hashable {
    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
    
    let id: String
    let title: String
    let description: String
    let imageUrl: URL?
    let action: () -> Void
}
