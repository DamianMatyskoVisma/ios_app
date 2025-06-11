import Foundation
import SwiftData

@Model
final class LaunchEntity {
    @Attribute(.unique) var id: String
    var name: String
    var dateUTC: String
    var success: Bool?
    var rocketId: String
    var details: String?
    var patchImage: String?
    var webcast: String?
    var article: String?
    var presskit: String?
    
    init(id: String, name: String, dateUTC: String, success: Bool?, rocketId: String, details: String?, patchImage: String?, webcast: String?, article: String?, presskit: String?) {
        self.id = id
        self.name = name
        self.dateUTC = dateUTC
        self.success = success
        self.rocketId = rocketId
        self.details = details
        self.patchImage = patchImage
        self.webcast = webcast
        self.article = article
        self.presskit = presskit
    }
} 