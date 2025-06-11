import Foundation
import SwiftData

@MainActor
class LaunchesViewModel: ObservableObject {
    private let modelContext: ModelContext
    private let favoritesKey = "favoriteLaunchIDs"
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        Task {
            await fetchAndSaveLaunches()
        }
    }
    
    func fetchAndSaveLaunches() async {
        do {
            let launches = try await SpaceXAPIService.fetchUpcomingLaunches()
            for launch in launches {
                if try modelContext.fetch(FetchDescriptor<LaunchEntity>(predicate: #Predicate { $0.id == launch.id })).isEmpty {
                    let entity = LaunchEntity(
                        id: launch.id,
                        name: launch.name,
                        dateUTC: launch.dateUTC,
                        success: launch.success,
                        rocketId: launch.rocket,
                        details: launch.details,
                        patchImage: launch.links?.patch?.small,
                        webcast: launch.links?.webcast,
                        article: launch.links?.article,
                        presskit: launch.links?.presskit
                    )
                    modelContext.insert(entity)
                }
            }
            let allEntities = try modelContext.fetch(FetchDescriptor<LaunchEntity>())
            updateAllFavorites(allEntities)
        } catch {
            print("Failed to fetch or save launches: \(error)")
        }
    }
    
    func formattedDate(_ iso: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: iso) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .long
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return iso
    }
    
    func toggleFavorite(for launch: LaunchEntity) {
        var favorites = favoriteIDs()
        if let idx = favorites.firstIndex(of: launch.id) {
            favorites.remove(at: idx)
        } else {
            favorites.append(launch.id)
        }
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
        updateFavorites(for: launch)
    }
    
    func isFavorite(for launch: LaunchEntity) -> Bool {
        favoriteIDs().contains(launch.id)
    }
    
    private func favoriteIDs() -> [String] {
        UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }
    
    func updateFavorites(for launch: LaunchEntity) {
        launch.isFavorite = isFavorite(for: launch)
        objectWillChange.send()
    }
    
    func updateAllFavorites(_ launches: [LaunchEntity]) {
        for launch in launches {
            updateFavorites(for: launch)
        }
    }
} 
