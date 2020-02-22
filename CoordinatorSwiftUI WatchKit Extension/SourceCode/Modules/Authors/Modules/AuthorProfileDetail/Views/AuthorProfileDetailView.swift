import SwiftUI

struct AuthorProfileDetailView: View {
    @ObservedObject
    private var viewModel: AuthorProfileDetailViewModel
    
    init(viewModel: AuthorProfileDetailViewModel) {
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
        let authorsStore = AuthorsStore.makeDummyFulfilled
        let authors = authorsStore.authors
        
        let firstPerson = authors[0]
        let secondPerson = authors[4]
        
        let firstViewModel = AuthorProfileDetailViewModel(
            author: firstPerson,
            store: authorsStore
        )
        
        let secondViewModel = AuthorProfileDetailViewModel(
            author: secondPerson,
            store: authorsStore
        )
        
        return Group {
            AuthorProfileDetailView(viewModel: firstViewModel)
            AuthorProfileDetailView(viewModel: secondViewModel)
        }
    }
}

#endif
