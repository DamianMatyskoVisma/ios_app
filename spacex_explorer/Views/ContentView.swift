//
//  ContentView.swift
//  spacex_explorer
//
//  Created by damian.matysko on 11/06/2025.
//

import SwiftUI
import SwiftData
import Kingfisher

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var launches: [LaunchEntity]
    @StateObject private var viewModel: LaunchesViewModel
    @State private var selectedLaunch: LaunchEntity?
    @State private var showApiError = false
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: LaunchesViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                KFImage(URL(string: "https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg")) //TODO: Move link to resources
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
                    .padding(.bottom, 8)
                List(launches) { launch in
                    HStack {
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
                        Spacer()
                        Button(action: {
                            viewModel.toggleFavorite(for: launch)
                        }) {
                            Image(systemName: viewModel.isFavorite(for: launch) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("SpaceX Launches")
            .navigationDestination(item: $selectedLaunch) { launch in
                DetailView(launch: launch, viewModel: viewModel)
            }
            .onChange(of: viewModel.apiError) { _, newValue in
                showApiError = newValue != nil
            }
            .alert("API Error", isPresented: $showApiError, actions: {
                Button("OK") {
                    viewModel.clearApiError()
                }
            }, message: {
                Text(viewModel.apiError ?? "Unknown error")
            })
        }
    }
}

//#Preview {
//    ContentView(modelContext: ModelContext())
//        .modelContainer(for: LaunchEntity.self, inMemory: true)
//}

