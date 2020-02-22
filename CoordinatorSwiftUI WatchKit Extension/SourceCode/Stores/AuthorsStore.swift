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
        let data = [
            ("Kirby Lumsden", 25, "Suspendisse sit amet ipsum et arcu iaculis sagittis.", true),
            ("Petra Wiersma", 18, "Curabitur consequat ipsum porta, cursus erat sed, volutpat augue.", false),
            ("Rachel Roth", 35, "Cras sed neque iaculis, tincidunt purus a, laoreet quam.", false),
            ("Stephenie Schwandt", 56, "Cras egestas orci ut magna dapibus, posuere consectetur mi fermentum.", false),
            ("Marielle Queener", 72, "Vestibulum sed leo congue, iaculis urna ut, accumsan lorem.", false),
            ("Kelsi Mcclane", 43, "Curabitur sit amet mi ut erat porta posuere nec quis est.", true),
            ("Cira Pender", 28, "Praesent sed felis eu nisl condimentum varius eget sit amet dui.", false),
            ("Ingeborg Mynatt", 64, "Nullam dictum arcu et sapien vulputate, a dictum eros maximus.", false),
            ("Signe Perrine", 12, "Suspendisse faucibus metus quis libero finibus, in hendrerit eros fringilla.", false),
            ("Elvera Pelayo", 32, "Ut bibendum odio pretium ex lacinia, non ullamcorper nulla accumsan.", false)
        ]
        
        let authors = data.map {
            Author(
                name: $0.0,
                age: $0.1,
                biography: $0.2,
                isEditor: $0.3
            )
        }
        
        let authorsStore = AuthorsStore()
        authorsStore.updateAuthors(authors)
        
        return authorsStore
    }
    
    static var makeDummyEmpty: AuthorsStore {
        let authorsStore = AuthorsStore()
        
        return authorsStore
    }
}


#endif
