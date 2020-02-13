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
    private var peopleStore = PeopleStore()
    
    // MARK: - Init
    init() {
        self.flowCase = .login
    }
    
    private lazy var authenticationView: AuthenticationView = {
        var authenticationView = AuthenticationView()
        authenticationView.delegate = self
        
        return authenticationView
    }()
    
    private lazy var peopleListView: PeopleListView = {
        let peopleProvider = PeopleProvider()
        
        let peopleListViewModel = PeopleListViewModel(
            provider: peopleProvider,
            store: peopleStore
        )
        
        var peopleListView = PeopleListView(
            viewModel: peopleListViewModel
        )
        
        peopleListView.delegate = self
        
        return peopleListView
    }()
    
    func start() -> AnyView {
        guard flowCase == .authenticated else {
            return authenticationView.any
        }
        
        return peopleListView
            .environmentObject(peopleStore) // This is a workaround to make possible rebuild PeopleListView every time PeopleStore instance is updated
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

extension ApplicationCoordinator: PeopleListViewDelegate {
    func peopleListView<Label>(_ view: PeopleListView, navigationLinkForPerson person: Person, viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label : View {
        
        let userProfileViewModel = ProfileDetailViewModel(
            person: person,
            store: peopleStore
        )
        
        let userProfileView = ProfileDetailView(
            viewModel: userProfileViewModel
        ).any
        
        let navigationLink = NavigationLink(
            destination: userProfileView,
            label: viewBuilder
        )
        
        return navigationLink
    }
    
    func peopleListViewDidFinishSession(_ view: PeopleListView) {
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
