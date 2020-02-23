import SwiftUI
import Combine

final class AuthorsStore: ObservableObject {
    @Published
    private(set) var authors: Authors = []
    
    func updateAuthors(_ authors: Authors) {
        self.authors = authors
    }
    
    func updateAuthor(_ author: Author) {
        guard let index = authors.firstIndex(where: { $0.id == author.id }) else {
            return
        }
        
        authors[index] = author
    }
    
    func deleteAuthor(at index: Int) {
        authors.remove(at: index)
    }
}

// MARK: - Dummy

#if DEBUG

extension AuthorsStore {
    static var makeDummyFulfilled: AuthorsStore {
        let authorsStore = AuthorsStore()
        let authors = Authors.makeDummy
        
        authorsStore.updateAuthors(authors)
        
        return authorsStore
    }
    
    static var makeDummyEmpty: AuthorsStore {
        let authorsStore = AuthorsStore()
        
        return authorsStore
    }
}


#endif
