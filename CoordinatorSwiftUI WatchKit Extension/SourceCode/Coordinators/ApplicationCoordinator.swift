import Combine
import SwiftUI

protocol Coordinator: AnyObject {
    func start() -> AnyView
}

final class ApplicationCoordinator: ObservableObject, Coordinator {
    enum FlowCase {
        case authenticated
        case login
    }
    
    @Published
    private var flowCase: FlowCase
    
    @Published
    private var authorsStore = AuthorsStore()
    
    // MARK: - Init
    init() {
        self.flowCase = .login
    }
    
    private lazy var authenticationView: AuthenticationView = {
        var authenticationView = AuthenticationView()
        authenticationView.delegate = self
        
        return authenticationView
    }()
    
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
    
    func start() -> AnyView {
        guard flowCase == .authenticated else {
            return authenticationView.any
        }
        
        return authorsListView
            .environmentObject(authorsStore) // This is a workaround to make possible rebuild AuthorsListView every time AuthorsStore instance is updated
            .any
    }
}

// MARK: - AuthenticationView Delegate

extension ApplicationCoordinator: AuthenticationViewDelegate {
    func authenticationViewDidFinish(_ view: AuthenticationView) {
        self.flowCase = .authenticated
    }
}

// MARK: - ProfileView Delegate

extension ApplicationCoordinator: AuthorsListViewDelegate {
    func authorsListView<Label>(_ view: AuthorsListView, navigationLinkForAuthor author: Author, viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label : View {
        
        let profileDetailViewModel = AuthorProfileDetailViewModel(
            author: author,
            store: authorsStore
        )
        
        let profileDetailView = AuthorProfileDetailView(
            viewModel: profileDetailViewModel
        ).any
        
        let navigationLink = NavigationLink(
            destination: profileDetailView,
            label: viewBuilder
        )
        
        return navigationLink
    }
    
    func authorsListViewDidFinishSession(_ view: AuthorsListView) {
        self.flowCase = .login
    }
}

// MARK: - Dummy

#if DEBUG

extension ApplicationCoordinator {
    static func makeDummy() -> ApplicationCoordinator {
        ApplicationCoordinator()
    }
}

#endif
