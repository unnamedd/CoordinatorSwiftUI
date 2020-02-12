import SwiftUI

protocol AuthenticationViewDelegate: AnyObject {
    func authenticationViewDidFinish(_ view: AuthenticationView)
}

struct AuthenticationView: View {
    weak var delegate: AuthenticationViewDelegate? = nil
    
    var body: some View {
        VStack {
            Text("Authentication")
            
            Button(action: { self.delegate?.authenticationViewDidFinish(self) }) {
                Text("Login")
            }
        }
    }
}

// MARK: - Dummy

#if DEBUG

final class AuthenticationViewDelegateMock: AuthenticationViewDelegate {
    private var isFinished = false
    
    func authenticationViewDidFinish(_ view: AuthenticationView) {
        isFinished = true
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        var authenticationView = AuthenticationView()
        let delegateMock = AuthenticationViewDelegateMock()
        
        authenticationView.delegate = delegateMock
        
        return authenticationView
    }
}

#endif
