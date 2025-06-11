//
//  spacex_explorerApp.swift
//  spacex_explorer
//
//  Created by damian.matysko on 11/06/2025.
//

import SwiftUI
import SwiftData

@main
struct spacex_explorerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            LaunchEntity.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
