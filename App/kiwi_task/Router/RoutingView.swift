import SwiftUI
import UmbrellaAPI

struct RoutingView<Content: View>: View {
    @StateObject var router: Router
    private let content: Content
    @EnvironmentObject private var persistenStore: PersistenStore
    @EnvironmentObject private var apiClient: Client
    
    init(router: Router, @ViewBuilder content: @escaping () -> Content) {
        _router = StateObject(wrappedValue: router)
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: router.navigationPath) {
            content
                .navigationDestination(for: SceneRoute.self) { sceneRoute in
                    router.configure(view: sceneRoute.view(persistenStore, apiClient), route: .navigation)
                }
        }.sheet(item: router.presentingSheet) { sceneRoute in
            router.configure(
                view: sceneRoute.view(persistenStore, apiClient),
                route: .sheet
            )
        }
    }
}
