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
                    Text(self.viewModel.fullname)
                        .font(.headline)
                        .fontWeight(.heavy)
                        .bold()
                        .lineLimit(1)
                        .padding(.bottom)
                }
                
                Text("Qtd. books: ")
                    .bold()
                    .foregroundColor(Color.gray)
                    +
                    Text("\(self.viewModel.author.numberOfBooks)")
                        .font(.caption)
                
                Text("Nationality: ")
                    .bold()
                    .foregroundColor(Color.gray)
                    +
                    Text("\(self.viewModel.author.nationality)")
                        .font(.caption)
                
                Divider()
                
                Text("Bio: ")
                    .bold()
                    .foregroundColor(Color.gray)
                    +
                    Text("\(self.viewModel.biography)")
                        .font(.caption)
                
                Divider()
                
                Toggle(
                    isOn: Binding<Bool>(
                        get: { self.viewModel.isFavourite },
                        set: { self.viewModel.updateAuthor($0) }
                    )
                ) {
                    Text("Favourite")
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
        let authorsStore = AuthorsStore.makeDummyFilled
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
