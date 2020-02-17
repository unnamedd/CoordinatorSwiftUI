import SwiftUI

struct ProfileDetailView: View {
    @ObservedObject
    private var viewModel: ProfileDetailViewModel
    
    init(viewModel: ProfileDetailViewModel) {
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
        .navigationBarTitle("\(viewModel.firstname)'s Detail")
    }
}

// MARK: - Dummy

#if DEBUG

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let peopleStore = PeopleStore.makeDummyFulfilled
        let people = peopleStore.people
        
        let firstPerson = people[0]
        let secondPerson = people[4]
        
        let firstViewModel = ProfileDetailViewModel(
            person: firstPerson,
            store: peopleStore
        )
        
        let secondViewModel = ProfileDetailViewModel(
            person: secondPerson,
            store: peopleStore
        )
        
        return Group {
            ProfileDetailView(viewModel: firstViewModel)
            ProfileDetailView(viewModel: secondViewModel)
        }
    }
}

#endif
