import Foundation
import UmbrellaAPI

struct PersistentPlace {
    let legacyId: String?
    let id: String
    let lat: Double
    let lng: Double
    let name: String
}

extension Array where Element == PlaceEdge {
    var persistentPlaces: [PersistentPlace]? {
        compactMap { edge -> PersistentPlace? in
            guard let node = edge.node else {
                return nil
            }
            return PersistentPlace(
                legacyId: node.legacyId,
                // this should not happen. Need to change graphql models from global to query specific
                id: node.id ?? "",
                lat: node.gps?.lat ?? 0,
                lng: node.gps?.lng ?? 0,
                name: node.name ?? ""
            )
        }
    }
}
