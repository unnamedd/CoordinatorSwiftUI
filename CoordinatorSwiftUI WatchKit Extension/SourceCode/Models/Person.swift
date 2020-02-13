import Foundation

typealias People = [Person]

struct Person: Identifiable, KeyPathUpdatable {
    let id = UUID()
    var name: String
    var age: Int
    var biography: String
    var isAuthor: Bool
}
