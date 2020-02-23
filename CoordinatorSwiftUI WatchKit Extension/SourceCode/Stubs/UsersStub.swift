import Foundation

extension Users {
    static var makeDummy: Users {
        do {
            return try File.load("Users")
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
}
