import SwiftUI
import UIKit

struct MyProfileView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator
    
    var body: some View {
        List {
            ForEach(coordinator.people, id: \.identifier) { person in
                self.coordinator.selectPerson(person) {
                    PersonRowView(person: person)
                }
            }
            .onDelete(perform: delete)
        }
        .navigationBarTitle(Text("User X"))
        .edgesIgnoringSafeArea([.leading, .bottom, .trailing])
        .contextMenu {
            Button(action: { self.coordinator.logout() }) {
                LogoutButtonView()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            _ = withAnimation {
                coordinator.people.remove(at: first)
            }
        }
    }
}

#if DEBUG
struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyProfileView()
                .environmentObject(ApplicationCoordinator())
        }
    }
}
#endif
