import Foundation
import SwiftUI
import Orbit

struct SearchPlacesView<VM: SearchPlacesViewModelType>: View {
    @StateObject private var viewModel: VM
    @EnvironmentObject private var router: Router
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        RoutingView(router: router) {
            VStack {
                List(viewModel.output.items) { item in
                    switch item {
                    case let .searchResult(viewModel):
                        ChoiceTile(
                            viewModel.title,
                            icon: .airplane,
                            isSelected: viewModel.isSelected,
                            action: viewModel.onTap
                        )
                    case let .empty(text):
                        EmptyState(text, illustration: .noResults)
                    }
                }
                Button("Confirm", type: .primary) {
                    viewModel.input.confirm.send(())
                }
                .padding()
            }
            .listRowInsets(EdgeInsets())
            .searchable(text: $viewModel.input.searchText)
            .onReceive(viewModel.output.close) {
                router.dismiss()
            }
        }
    }
}

struct SearchPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesView(
            viewModel: SearchPlacesViewModel(
                service: SearchPlacesService(apiClient: PreviewAPIClient())
            ) { _ in
                
            }
        )
    }
}
