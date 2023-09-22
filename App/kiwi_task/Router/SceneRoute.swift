import Foundation
import SwiftUI
import UmbrellaAPI
import Combine

enum SceneRoute {
    case flightList
    case filter(done: FilterOptionsViewModel.Done)
    case searchPlaces(done: SearchPlacesViewModel.Done)
    case flightDetail(_ itinerary: Itinerary)
}

extension SceneRoute {
    @ViewBuilder
    func view(_ persistentStore: PersistenStorage, _ apiClient: Client) -> some View {
        switch self {
        case let .filter(done):
            FilterOptionsView(
                viewModel: FilterOptionsViewModel(
                    service: FilterOptionsService(client: apiClient),
                    persistenStorage: persistentStore,
                    done: done
                )
            )
        case let .searchPlaces(done):
            SearchPlacesView(
                viewModel: SearchPlacesViewModel(
                    service: SearchPlacesService(apiClient: apiClient),
                    done: done
                )
            )
        case let .flightDetail(itinerary):
            FlightDetailView(
                viewModel: FlightDetailViewModel(itinerary: itinerary)
            )
        case .flightList:
            FlightListView(
                viewModel: FlightListViewModel(
                    service: FlightListService(client: apiClient),
                    persistStore: persistentStore
                )
            )
        }
    }
}

extension SceneRoute: Identifiable {
    var id: String {
        switch self {
        case .flightList:
            return "flightList"
        case .filter:
            return "filter"
        case .searchPlaces:
            return "searchPlaces"
        case .flightDetail:
            return "flightDetail"
        }
    }
}

extension SceneRoute: Hashable {
    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

extension SceneRoute: Equatable {
    static func == (lhs: SceneRoute, rhs: SceneRoute) -> Bool {
        lhs.id == rhs.id
    }
}
