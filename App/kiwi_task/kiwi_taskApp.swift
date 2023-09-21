import SwiftUI
import UmbrellaAPI

@main
struct kiwi_taskApp: App {
    @StateObject private var persistentStore: PersistenStore = CoreDataStore()
    @StateObject private var apiClient = try! Client(baseURL: Config.graphqlBaseUrl)
    
    var body: some Scene {
        WindowGroup {
            FlightListView(
                viewModel: FlightListViewModel(
                service: FlightListService(client: apiClient)
                )
            )
            .environmentObject(Router(isPresented: .constant(.flightList)))
            .environmentObject(persistentStore)
            // If the url is wrong, then let it crash so it will be observed during an app test
            .environmentObject(apiClient)
        }
    }
}
