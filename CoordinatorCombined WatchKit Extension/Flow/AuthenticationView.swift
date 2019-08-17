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
