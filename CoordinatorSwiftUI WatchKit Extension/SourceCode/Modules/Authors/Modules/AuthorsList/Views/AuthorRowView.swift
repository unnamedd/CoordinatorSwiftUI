import SwiftUI

struct AuthorRowView: View {
    var author: Author
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(author.name)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)

                Spacer()
            }
            .padding(.vertical, 0)
            
            Divider().frame(height: 1)
            
            HStack(alignment: .top) {
                Text("Nationality: ").bold()
                +
                Text("\(author.nationality)")
                    .font(.caption)
                    .fontWeight(.thin)
            }
        }
        .padding(.vertical, 5)
    }
}

// MARK: - Dummy

#if DEBUG

struct AuthorRowView_Previews: PreviewProvider {
    static var previews: some View {
        let authorsStore = AuthorsStore.makeDummyFilled
        let authors = authorsStore.authors
        
        return List(0..<6) { index in
            AuthorRowView(author: authors[index])
        }
    }
}

#endif
