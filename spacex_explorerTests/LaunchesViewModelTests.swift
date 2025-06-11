import XCTest
import SwiftData
@testable import spacex_explorer

@MainActor
final class LaunchesViewModelTests: XCTestCase {
    var modelContext: ModelContext!
    var viewModel: LaunchesViewModel!
    
    override func setUp() {
        super.setUp()
        let schema = Schema([LaunchEntity.self, RocketEntity.self])
        do {
            let container = try ModelContainer(for: schema, configurations: [ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)])
            modelContext = container.mainContext
            viewModel = LaunchesViewModel(modelContext: modelContext)
        } catch {
            XCTFail("Failed to create ModelContainer: \(error)")
        }
    }
    
//    func testFavoriteToggle() {
//        let launch = LaunchEntity(id: "1", name: "Test Launch", dateUTC: "2022-01-01T00:00:00.000Z", success: true, rocketId: "r1", details: nil, patchImage: nil, webcast: nil, article: nil, presskit: nil)
//        modelContext.insert(launch)
//        XCTAssertFalse(viewModel.isFavorite(for: launch))
//        viewModel.toggleFavorite(for: launch)
//        XCTAssertTrue(viewModel.isFavorite(for: launch))
//        viewModel.toggleFavorite(for: launch)
//        XCTAssertFalse(viewModel.isFavorite(for: launch))
//    }
    
    func testDateFormatting() {
        let iso = "2022-01-01T12:34:56.000Z"
        let formatted = viewModel.formattedDate(iso)
        XCTAssertFalse(formatted.contains("T")) // Should not be raw ISO
    }
}
