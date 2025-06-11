import Foundation

struct Launch: Codable, Identifiable {
    let id: String
    let name: String
    let dateUTC: String
    let success: Bool?
    let rocket: String
    let details: String?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, name, success, rocket, details, links
        case dateUTC = "date_utc"
    }
}

struct Links: Codable {
    let patch: Patch?
    let webcast: String?
    let article: String?
    let presskit: String?
}

struct Patch: Codable {
    let small: String?
    let large: String?
} 