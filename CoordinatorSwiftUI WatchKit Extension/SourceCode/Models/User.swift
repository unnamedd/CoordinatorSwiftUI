import Foundation

typealias Users = [User]

struct User: Codable, Identifiable {
    let id = UUID()
    let name: String
    let email: String
}
