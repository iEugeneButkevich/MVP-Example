import Foundation

struct User: Codable, Equatable {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case avatar = "avatar"
    }
}
