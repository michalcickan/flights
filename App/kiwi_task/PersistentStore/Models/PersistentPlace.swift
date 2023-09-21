import Foundation
import UmbrellaAPI

struct PersistentPlace {
    let imageUrl: String?
    let id: String
    let lat: Double
    let lng: Double
    let name: String
}

extension PlaceConnection {
    var persistentPlaces: [PersistentPlace]? {
        guard let edges else {
            return nil
        }
        return edges.compactMap { edge -> PersistentPlace? in
            guard let node = edge.node else {
                return nil
            }
            return PersistentPlace(
                imageUrl: node.legacyId,
                // this should not happen. Need to change graphql models from global to query specific
                id: node.id ?? "",
                lat: node.gps?.lat ?? 0,
                lng: node.gps?.lng ?? 0,
                name: node.name ?? ""
            )
        }
    }
}
