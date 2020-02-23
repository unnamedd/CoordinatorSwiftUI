import Foundation

final class UserManager {
    private let userDefaults = UserDefaults.standard

    private var user: User?
    
    static let shared = UserManager()
    
    private init() {}
    
    var isUserAuthenticated: Bool {
        user != nil
    }
    
    func clearData() {
        user = nil
    }
    
    func set(_ user: User) {
        self.user = user
    }
}
