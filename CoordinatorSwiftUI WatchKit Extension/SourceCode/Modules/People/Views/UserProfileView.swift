import SwiftUI

struct UserProfileView: View {
    @ObservedObject
    private var viewModel: UserProfileViewModel
    
    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    if self.viewModel.isAuthor {
                        Image(systemName: "pencil.and.outline")
                    }
                    
                    Text(self.viewModel.fullname)
                        .font(.headline)
                        .fontWeight(.heavy)
                        .bold()
                        .lineLimit(1)
                }
                
                Text("Age: ")
                    .bold()
                    .foregroundColor(Color.gray)
                    +
                    Text("\(self.viewModel.userAge)")
                        .font(.caption)
                
                Divider()
                
                Text("Bio: ")
                    .bold()
                    .foregroundColor(Color.gray)
                    +
                    Text("\(self.viewModel.biographyDescription)")
                        .font(.caption)
                
                Divider()
                
                Toggle(
                    isOn: Binding<Bool>(
                        get: { self.viewModel.isAuthor },
                        set: { self.viewModel.updateAuthor($0) }
                    )
                ) {
                    Text("Author")
                }
                .padding(.trailing)
            }
        }
    }
}

// MARK: - Dummy

#if DEBUG

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let peopleStore = PeopleStore.makeDummyFulfilled
        let people = peopleStore.people
        
        let firstPerson = people[0]
        let secondPerson = people[4]
        
        let firstViewModel = UserProfileViewModel(
            person: firstPerson,
            store: peopleStore
        )
        
        let secondViewModel = UserProfileViewModel(
            person: secondPerson,
            store: peopleStore
        )
        
        return Group {
            UserProfileView(viewModel: firstViewModel)
            UserProfileView(viewModel: secondViewModel)
        }
    }
}

#endif
