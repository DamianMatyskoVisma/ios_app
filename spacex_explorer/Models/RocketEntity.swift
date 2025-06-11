import Foundation
import SwiftData

@Model
final class RocketEntity {
    @Attribute(.unique) var id: String
    var name: String
    var height: Double?
    var diameter: Double?
    var mass: Int?
    var firstFlight: String?
    var descriptionText: String?
    var successRatePct: Int?
    var active: Bool?
    var costPerLaunch: Int?
    var patchImage: String?
    
    init(id: String, name: String, height: Double?, diameter: Double?, mass: Int?, firstFlight: String?, descriptionText: String?, successRatePct: Int?, active: Bool?, costPerLaunch: Int?, patchImage: String?) {
        self.id = id
        self.name = name
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.firstFlight = firstFlight
        self.descriptionText = descriptionText
        self.successRatePct = successRatePct
        self.active = active
        self.costPerLaunch = costPerLaunch
        self.patchImage = patchImage
    }
} 