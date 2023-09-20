import Foundation
import SwiftUI

enum Route: Equatable, Hashable {
    case flightList
    case filter
    case searchPlaces
}

extension Route {
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

extension Route: Identifiable {
    var id: Self { self }
}
