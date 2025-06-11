import Foundation

struct Rocket: Codable, Identifiable {
    let id: String
    let name: String
    let height: Dimension
    let diameter: Dimension
    let mass: Mass
    let firstFlight: String
    let description: String
    let successRatePct: Int
    let active: Bool
    let costPerLaunch: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, height, diameter, mass, description, active
        case firstFlight = "first_flight"
        case successRatePct = "success_rate_pct"
        case costPerLaunch = "cost_per_launch"
    }
}

struct Dimension: Codable {
    let meters: Double?
    let feet: Double?
}

struct Mass: Codable {
    let kg: Int?
    let lb: Int?
} 