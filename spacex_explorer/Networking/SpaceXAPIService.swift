import Foundation

enum SpaceXAPIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

struct SpaceXAPIService {
    static let baseURLv5 = "https://api.spacexdata.com/v5"
    static let baseURLv4 = "https://api.spacexdata.com/v4"
    
    // Fetch latest launch
    static func fetchLatestLaunch() async throws -> Launch {
        guard let url = URL(string: "\(baseURLv5)/launches/latest") else { throw SpaceXAPIError.invalidURL }
        return try await fetch(url: url)
    }
    
    // Fetch upcoming launches
    static func fetchUpcomingLaunches() async throws -> [Launch] {
        guard let url = URL(string: "\(baseURLv5)/launches/upcoming") else { throw SpaceXAPIError.invalidURL }
        return try await fetch(url: url)
    }
    
    // Fetch launch detail by id
    static func fetchLaunchDetail(id: String) async throws -> Launch {
        guard let url = URL(string: "\(baseURLv5)/launches/\(id)") else { throw SpaceXAPIError.invalidURL }
        return try await fetch(url: url)
    }
    
    // Fetch rocket detail by id
    static func fetchRocketDetail(id: String) async throws -> Rocket {
        guard let url = URL(string: "\(baseURLv4)/rockets/\(id)") else { throw SpaceXAPIError.invalidURL }
        return try await fetch(url: url)
    }
    
    // Generic fetch method
    private static func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SpaceXAPIError.requestFailed
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw SpaceXAPIError.decodingFailed
        }
    }
} 