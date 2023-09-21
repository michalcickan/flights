import Foundation
import SwiftUI
import Orbit

struct FlightListView<VM: FlightListViewModelType>: View {
    @StateObject private var viewModel: VM
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var persistenStore: PersistenStorage
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        RoutingView(router: router) {
            VStack {
                Button("Test", icon: Icon.Symbol.accountCircle) {
                    viewModel.input.onAppear.send(())
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                print("test")
            }
            .onReceive(viewModel.output.showRoute) { route in
                router.present(route, with: route.routeType)
            }
        }
    }
}

struct FlightListView_Previews: PreviewProvider {
    static var previews: some View {
        FlightListView(
            viewModel: FlightListViewModel(
                service: FlightListService(
                    client: PreviewAPIClient()
                ),
                persistStore: PersistenStorage()
            )
        )
    }
}

fileprivate extension SceneRoute {
    var routeType: Router.RouteType {
        switch self {
        case .filter:
            return .sheet
        default:
            return .navigation
        }
    }
}
