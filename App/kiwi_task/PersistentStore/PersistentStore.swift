import Foundation
import UmbrellaAPI

// Cannot insert protocol as environment object
open class PersistenStorage: ObservableObject {
    var places: [PersistentPlace]?
    var filter: PersistentFilter?
}
