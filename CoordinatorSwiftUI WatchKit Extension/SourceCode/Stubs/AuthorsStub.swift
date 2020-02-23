import Foundation

extension Authors {
    static var makeDummy: Authors {
        do {
            return try File.load("Authors")
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
}
