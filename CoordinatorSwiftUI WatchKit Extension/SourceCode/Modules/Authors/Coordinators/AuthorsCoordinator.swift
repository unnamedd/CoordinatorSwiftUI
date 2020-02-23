import SwiftUI

// MARK: - Coordinator Delegate Protocol

protocol AuthorsCoordinatorDelegate: AnyObject {
    func authorsCoordinatorDidFinish(_ coordinator: AuthorsCoordinator)
}

// MARK: - Coordinator

final class AuthorsCoordinator: Coordinator {
    @Published
    private var authorsStore = AuthorsStore()
    
    private lazy var authorsListView: AuthorsListView = {
        let authorsProvider = AuthorsProvider()
        
        let authorsListViewModel = AuthorsListViewModel(
            provider: authorsProvider,
            store: authorsStore
        )
        
        var authorsListView = AuthorsListView(
            viewModel: authorsListViewModel
        )
        
        authorsListView.delegate = self
        
        return authorsListView
    }()
    
    private func authorProfileDetailView(for author: Author) -> AuthorProfileDetailView {
        let profileDetailViewModel = AuthorProfileDetailViewModel(
            author: author,
            store: authorsStore
        )
        
        let authorProfileDetailView = AuthorProfileDetailView(
            viewModel: profileDetailViewModel
        )
        
        return authorProfileDetailView
    }
    
    weak var delegate: AuthorsCoordinatorDelegate?
    
    // MARK: - Initialisation
    
    override init() {
        super.init()
    }
    
    override func start() -> AnyView {
        return authorsListView
            // This is a workaround. It is here to make possible rebuild AuthorsListView every time AuthorsStore instance is updated
            .environmentObject(authorsStore)
            .any
    }
}

// MARK: - AuthorsListView Delegate

extension AuthorsCoordinator: AuthorsListViewDelegate {
    
    func authorsListViewDidFinishSession(_ view: AuthorsListView) {
        delegate?.authorsCoordinatorDidFinish(self)
    }
    
    func authorsListView<Label>(_ view: AuthorsListView, navigationLinkForAuthor author: Author, viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label : View {
        
        let navigationLink = NavigationLink(
            destination: authorProfileDetailView(for: author).any,
            label: viewBuilder
        )
        
        return navigationLink
    }
    
    
}
