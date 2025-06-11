import Foundation
import SwiftData

@MainActor
class LaunchesViewModel: ObservableObject {
    private let modelContext: ModelContext
    
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
        } catch {
            print("Failed to fetch or save launches: \(error)")
        }
    }
} 
