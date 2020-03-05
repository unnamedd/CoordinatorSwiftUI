import SwiftUI

final class AuthorsListViewModel: ObservableObject {
    private var provider: AuthorsProviderProtocol

    private var authorsStore: AuthorsStore
    
    @Published
    private(set) var state: AuthorsListViewModel.State = .initial
    
    var authors: Authors {
        authorsStore.authors
    }
    
    init(provider: AuthorsProviderProtocol, store: AuthorsStore) {
        self.provider = provider
        self.authorsStore = store
    }
    
    func loadAuthors() {
        state = .loading
        
        provider.listAuthors { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
                case .success(let authors):
                    self.state = .list
                    self.authorsStore.updateAuthors(authors)
                
                case .failure:
                    self.state = .error
            }
        }
    }
    
    func refreshList() {
        objectWillChange.send()
    }
    
    func deleteAuthor(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        
        _ = withAnimation {
            self.authorsStore.deleteAuthor(at: index)
            objectWillChange.send()
        }
    }
}

#if DEBUG

extension AuthorsListViewModel {
    static var makeSuccessDummy: AuthorsListViewModel {
        let viewModel = AuthorsListViewModel(
            provider: AuthorsProviderSuccessMock(),
            store: AuthorsStore.makeDummyFilled
        )
        
        viewModel.state = .initial
        
        return viewModel
    }
    
    static var makeFailureDummy: AuthorsListViewModel {
        return AuthorsListViewModel(
            provider: AuthorsProviderFailureMock(),
            store: AuthorsStore.makeDummyEmpty
        )
    }
}

#endif
