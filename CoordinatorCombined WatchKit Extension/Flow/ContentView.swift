import SwiftUI

struct ContentView: View {
    @ObservedObject var coordinator: ApplicationCoordinator
    
    var body: some View {
        coordinator.start()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: ApplicationCoordinator())
    }
}
#endif

// MARK: -
struct MyProfileView: View {
    @ObservedObject var coordinator: ApplicationCoordinator
    
    var body: some View {
        ScrollView {
            VStack {
                Text("User X")
                
                Divider()
                
                ForEach(coordinator.people) { person in
                    self.coordinator.selectPerson(person) {
                        Text(person.name)
                    }
                }
                
                Divider()
                
                Button(action: { self.coordinator.logout() }) {
                    Text("Logout")
                }
                .background(Color.clear)
            }
        }
        .navigationBarTitle("My Profile")
    }
}

// MARK: -
struct UserProfileView: View {
    var person: Person
    
    var body: some View {
        VStack {
            Text(person.name)
            Text("Age: \(person.age)")
        }
    }
}

// MARK: -
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
