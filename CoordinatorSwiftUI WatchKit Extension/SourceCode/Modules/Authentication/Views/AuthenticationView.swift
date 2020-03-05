import SwiftUI

protocol AuthenticationViewDelegate: AnyObject {
    func authenticationView(_ view: AuthenticationView, didFinishAuthentication user: User)
}

struct AuthenticationView: View {
    @State
    private var emailValue = ""
    
    @State
    private var passwordValue = ""
    
    @State
    private var saveLogin = true
    
    weak var delegate: AuthenticationViewDelegate? = nil
    
    var body: some View {
        VStack {
            Text("Authentication")
            
            TextField("Email", text: $emailValue)
                .textContentType(.emailAddress)
                .frame(height: 30)
            
            SecureField("Password", text: $passwordValue)
                .textContentType(.password)
            
            Toggle("Save login", isOn: $saveLogin)
            
            Button(action: {
                let user = Users.makeDummy[0]
                self.delegate?.authenticationView(self, didFinishAuthentication: user)
                
            }) {
                Text("Login")
            }
        }
    }
}

// MARK: - Dummy

#if DEBUG

final class AuthenticationViewDelegateMock: AuthenticationViewDelegate {
    private var isFinished = false

    func authenticationView(_ view: AuthenticationView, didFinishAuthentication user: User) {
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
