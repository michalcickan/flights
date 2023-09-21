import Foundation
import SwiftUI
import UmbrellaAPI

enum SceneRoute: Equatable, Hashable {
    case flightList
    case filter
    case searchPlaces
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
        default:
            EmptyView()
        }
    }
}

extension SceneRoute: Identifiable {
    var id: Self { self }
}
