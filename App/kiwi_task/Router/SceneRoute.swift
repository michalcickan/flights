import Foundation
import SwiftUI

enum SceneRoute: Equatable, Hashable {
    case flightList
    case filter
    case searchPlaces
}

extension SceneRoute {
    @ViewBuilder
    var view: some View {
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
