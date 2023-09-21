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
    func view(_ persistentStore: PersistenStore, _ apiClient: Client) -> some View {
        switch self {
        case .filter:
            FilterOptionsView(
                viewModel: FilterOptionsViewModel()
            )
        default:
            EmptyView()
        }
    }
}

extension SceneRoute: Identifiable {
    var id: Self { self }
}
