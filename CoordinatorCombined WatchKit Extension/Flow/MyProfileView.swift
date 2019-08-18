import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator
    
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
