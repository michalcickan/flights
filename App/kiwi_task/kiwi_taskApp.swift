//
//  kiwi_taskApp.swift
//  kiwi_task
//
//  Created by Michal Cickan on 18/09/2023.
//

import SwiftUI

@main
struct kiwi_taskApp: App {
    @StateObject private var persistentStore: PersistenStore = CoreDataStore()
    
    var body: some Scene {
        WindowGroup {
            FlightListView(
                viewModel: FlightListViewModel()
            )
            .environmentObject(Router(isPresented: .constant(.flightList)))
            .environmentObject(persistentStore)
        }
    }
}
