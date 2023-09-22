import Foundation
import UmbrellaAPI

class FlightDetailViewModel: FlightDetailInput, ObservableObject {
    private let itinerary: Itinerary
    
    
    init(itinerary: Itinerary) {
        self.itinerary = itinerary
    }
}

extension FlightDetailViewModel: FlightDetailOutput {
    var direction: String {
        itinerary.sector?.direction ?? "-"
    }
    
    var stops: ListSection<CardViewModel> {
        ListSection(
           title: "Stops",
           items: itinerary.sector?.sectorSegments?.map {
               CardViewModel(
                id: $0.segment?.id ?? "-",
                   title: "\($0.segment?.source?.station?.name ?? "-") -> \($0.segment?.destination?.station?.name ?? "-")",
                   description: $0.description,
                imageUrl: $0.segment?.source?.station?.city?.legacyId?.urlFromLegacyId
               ) {

               }
           } ?? []
       )
    }
    
    var title: String {
        itinerary.sector?.shortDirection ?? "Flight"
    }
    
    var highlightTag: HighlightType {
        if itinerary.highlights?.isBest ?? false {
            return .best
        } else if itinerary.highlights?.isCheapest ?? false {
            return .cheapest
        } else if itinerary.highlights?.isFastest ?? false {
            return .fastest
        }
        return .none
    }
    
    var price: String {
        itinerary.price?.formattedValue ?? "-"
    }
    
    var totalDuration: String {
        itinerary.duration?.secondsToTime ?? "-"
    }
    
    var bookingLinks: [LinkViewModel] {
        itinerary.bookingOptions?.edges?
            .map {
                LinkViewModel(
                    title: "For price \($0.node.price?.formattedValue ?? "-")",
                    destinationUrl: URL(string: "\(Config.baseBookingUrl)/\($0.node.bookingUrl ?? "")")!
                )
                
            } ?? []
    }
}

extension FlightDetailViewModel: FlightDetailViewModelType {
    var input: FlightDetailInput { get { self } set { } }
    var output: any FlightDetailOutput { self }
}

fileprivate extension SectorSegment {
    var description: String {
        let description = "\(segment?.source?.station?.name ?? "-") -> \(segment?.destination?.station?.name ?? "-")"
        guard let layoverDuration = layover?.duration else {
            return description
        }
        return "\(description)\nEstimated time spent \(layoverDuration.secondsToTime)"
    }
}
