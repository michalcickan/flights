import Foundation
import Orbit

struct CardViewModel: Identifiable {
    var id: ObjectIdentifier
    
    let title: String
    let description: String
    let action: CardAction
}
