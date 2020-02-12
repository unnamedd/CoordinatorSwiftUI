import Combine
import SwiftUI

enum StateCase {
    case authenticated
    case login
}

protocol Coordinator: AnyObject {
    func start() -> AnyView
}

final class ApplicationCoordinator: ObservableObject, Coordinator {
    @Published private var stateCase: StateCase
    
    // MARK: - Init
    init() {
        self.stateCase = .login
    }
    
    private lazy var authenticationView: AuthenticationView = {
        var authenticationView = AuthenticationView()
        authenticationView.delegate = self
        
        return authenticationView
    }()
    
    private lazy var peopleListView: PeopleListView = {
        let peopleProvider = PeopleProvider()
        let peopleListViewModel = PeopleListViewModel(
            provider: peopleProvider
        )
        
        var peopleListView = PeopleListView(
            viewModel: peopleListViewModel
        )
        
        peopleListView.delegate = self
        
        return peopleListView
    }()
    
    func start() -> AnyView {
        guard stateCase == .authenticated else {
            return authenticationView.any
        }
        
        return peopleListView.any
    }
}

// MARK: - AuthenticationView Delegate

extension ApplicationCoordinator: AuthenticationViewDelegate {
    func authenticationViewDidFinish(_ view: AuthenticationView) {
        self.stateCase = .authenticated
    }
}

// MARK: - ProfileView Delegate

extension ApplicationCoordinator: PeopleListViewDelegate {
    func peopleListView<Label>(_ view: PeopleListView, navigationLinkViewForPerson person: Person, viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label : View {
        let userProfileView = UserProfileView(person: person).any
        let navigationLink = NavigationLink(destination: userProfileView, label: viewBuilder)
        
        return navigationLink
    }
    
    func peopleListViewDidFinishSession(_ view: PeopleListView) {
        self.stateCase = .login
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
