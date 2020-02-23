import Combine
import SwiftUI

final class ApplicationCoordinator: Coordinator, ObservableObject {
    
    @Published
    private var userManager = UserManager.shared
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    override func start() -> AnyView {
        guard userManager.isUserAuthenticated else {
            return startAuthentication()
        }
        
        return startAuthors()
    }
    
    func startAuthentication() -> AnyView {
        let authenticationCoordinator = AuthenticationCoordinator()
        authenticationCoordinator.delegate = self
        
        addChild(authenticationCoordinator)
        
        return authenticationCoordinator.start()
    }
    
    func startAuthors() -> AnyView {
        let authorsCoordinator = AuthorsCoordinator()
        authorsCoordinator.delegate = self
        
        addChild(authorsCoordinator)
        
        return authorsCoordinator.start()
    }
}

// MARK: - AuthenticationCoordinator Delegate

extension ApplicationCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(_ coordinator: AuthenticationCoordinator, didFinishAuthentication user: User) {
        removeChild(coordinator)
        
        userManager.set(user)
        self.objectWillChange.send()
    }
}

// MARK: - AuthorsCoordinator Delegate

extension ApplicationCoordinator: AuthorsCoordinatorDelegate {
    func authorsCoordinatorDidFinish(_ coordinator: AuthorsCoordinator) {
        removeChild(coordinator)
        
        userManager.clearData()
        self.objectWillChange.send()
    }
}



// MARK: - Dummy

#if DEBUG

extension ApplicationCoordinator {
    static func makeDummy() -> ApplicationCoordinator {
        ApplicationCoordinator()
    }
}

#endif
