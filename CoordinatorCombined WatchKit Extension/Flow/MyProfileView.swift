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
        }
        .navigationBarTitle("My Profile")
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyProfileView()
                .environmentObject(ApplicationCoordinator())
        }
        //.previewLayout(.fixed(width: 170, height: 1580))
    }
}
#endif
