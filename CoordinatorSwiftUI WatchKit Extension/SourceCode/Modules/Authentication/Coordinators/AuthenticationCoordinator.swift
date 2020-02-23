import SwiftUI

protocol AuthenticationCoordinatorDelegate: AnyObject {
    func authenticationCoordinator(_ coordinator: AuthenticationCoordinator, didFinishAuthentication user: User)
}

final class AuthenticationCoordinator: Coordinator {
    
    private lazy var authenticationView: AuthenticationView = {
        var authenticationView = AuthenticationView()
        authenticationView.delegate = self
        
        return authenticationView
    }()
    
    weak var delegate: AuthenticationCoordinatorDelegate?
    
    override init() {
        super.init()
    }
    
    override func start() -> AnyView {
        return authenticationView.any
    }
}

extension AuthenticationCoordinator: AuthenticationViewDelegate {
    func authenticationView(_ view: AuthenticationView, didFinishAuthentication user: User) {
        delegate?.authenticationCoordinator(self, didFinishAuthentication: user)
    }
}
