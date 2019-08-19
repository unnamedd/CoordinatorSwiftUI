import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator
    
    var body: some View {
        ScrollView {
            VStack {
                Text("User X")
                
                Divider()
                
                ForEach(coordinator.people, id: \.identifier) { person in
                    self.coordinator.selectPerson(person) {
                        PersonRowView(person: person)
                    }
                }
                
                Divider()
                
                Button(action: { self.coordinator.logout() }) {
                    Text("Logout")
                }
                .background(Color.clear)
            }
            .padding(.top, -150)
        }
        .navigationBarTitle("My Profile")
    }
}

#if DEBUG
struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyProfileView()
                .environmentObject(ApplicationCoordinator())
            
            MyProfileView()
                .environmentObject(ApplicationCoordinator())
        }
    }
}
#endif
