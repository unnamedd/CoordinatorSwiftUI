import SwiftUI

final class AuthorProfileDetailViewModel: ObservableObject {
    private var authorsStore: AuthorsStore
    
    @Published
    private var author: Author
    
    var fullname: String {
        author.name
    }
    
    var firstname: String {
        let names = fullname.split(separator: " ")
        
        guard let firstname = names.first else {
            return fullname
        }
        
        return String(firstname)
    }
    
    var userAge: Int {
        author.age
    }
    
    var biographyDescription: String {
        author.biography
    }
 
    var isAuthor: Bool {
        author.isEditor
    }
    
    init(author: Author, store: AuthorsStore) {
        self.authorsStore = store
        self.author = author
    }
    
    func updateAuthor(_ isAuthor: Bool) {
        self.author = self.author.updating(\.isEditor, to: isAuthor)
        authorsStore.updateAuthor(author)
    }
    
    func loadAuthorDetails() {
        
    }
}

// MARK: - Dummy

#if DEBUG

extension AuthorProfileDetailViewModel {
    static var makeDummy: AuthorProfileDetailViewModel {
        let authorsStore = AuthorsStore.makeDummyFulfilled
        let author = authorsStore.authors[5]
        
        return AuthorProfileDetailViewModel(
            author: author,
            store: authorsStore
        )
    }
}

#endif
