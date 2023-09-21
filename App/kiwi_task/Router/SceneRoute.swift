import Foundation
import SwiftUI
import UmbrellaAPI
import Combine

enum SceneRoute {
    case flightList
    case filter
    case searchPlaces(doneClosure: SearchPlacesViewModel.Done)
}

extension SceneRoute {
    @ViewBuilder
    func view(_ persistentStore: PersistenStorage, _ apiClient: Client) -> some View {
        switch self {
        case .filter:
            FilterOptionsView(
                viewModel: FilterOptionsViewModel(
                    service: FilterOptionsService(client: apiClient),
                    persistenStorage: persistentStore
                )
            )
        case let .searchPlaces(doneClosure):
            SearchPlacesView(
                viewModel: SearchPlacesViewModel(
                    service: SearchPlacesService(apiClient: apiClient),
                    done: doneClosure
                )
            )
            
        default:
            EmptyView()
        }
    }
}

extension SceneRoute: Identifiable {
    var id: String {
        switch self {
        case .flightList:
            return "flightTest"
        case .filter:
            return "filter"
        case .searchPlaces:
            return "searchPlaces"
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
