import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var coordinator: ApplicationCoordinator
    
    var body: some View {
        VStack {
            Text("Authentication")
            
            Button(action: { self.coordinator.login() }) {
                Text("Login")
            }
        }
    }
}

// MARK: - Dummy

#if DEBUG

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(
            coordinator: ApplicationCoordinator.makeDummy()
        )
    }
}

#endif
