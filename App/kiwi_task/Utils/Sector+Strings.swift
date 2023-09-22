import UmbrellaAPI
import Foundation

extension Sector {
    var direction: String {
        guard let outbound = sectorSegments?.first?.segment?.source?.station?.name,
              let inbound = sectorSegments?.last?.segment?.destination?.station?.name else {
            return "-"
        }
        return "\(outbound) -> \(inbound)"
    }
    
    var shortDirection: String {
        guard let outbound = sectorSegments?.first?.segment?.source?.station?.code,
              let inbound = sectorSegments?.last?.segment?.destination?.station?.code else {
            return "-"
        }
        return "\(outbound) -> \(inbound)"
    }
}

extension String {
    var urlFromLegacyId: URL? {
        URL(string: "\(Config.photoBaseUrl)/\(self).jpg")
    }
}
