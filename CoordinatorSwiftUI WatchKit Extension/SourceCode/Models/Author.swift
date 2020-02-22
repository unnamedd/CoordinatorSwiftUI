import Foundation

typealias Authors = [Author]

struct Author: Identifiable, KeyPathUpdatable {
    let id = UUID()
    var name: String
    var age: Int
    var biography: String
    var isEditor: Bool
}
