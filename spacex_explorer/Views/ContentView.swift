//
//  ContentView.swift
//  spacex_explorer
//
//  Created by damian.matysko on 11/06/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var launches: [LaunchEntity]
    @StateObject private var viewModel: LaunchesViewModel

    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: LaunchesViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(launches) { launch in
                    NavigationLink {
                        Text(launch.name)
                    } label: {
                        Text(launch.name)
                    }
                }
            }
        } detail: {
            Text("Select a launch")
        }
    }
}

//#Preview {
//    ContentView(modelContext: ModelContext())
//        .modelContainer(for: LaunchEntity.self, inMemory: true)
//}
