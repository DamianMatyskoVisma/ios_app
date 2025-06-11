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
    @State private var selectedLaunch: LaunchEntity?
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: LaunchesViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationStack {
            List(launches) { launch in
                Button {
                    selectedLaunch = launch
                } label: {
                    VStack(alignment: .leading) {
                        Text(launch.name)
                            .font(.headline)
                        Text(viewModel.formattedDate(launch.dateUTC))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("SpaceX Launches")
            .navigationDestination(item: $selectedLaunch) { launch in
                DetailView(launch: launch, viewModel: viewModel)
            }
        }
    }
}

//#Preview {
//    ContentView(modelContext: ModelContext())
//        .modelContainer(for: LaunchEntity.self, inMemory: true)
//}

