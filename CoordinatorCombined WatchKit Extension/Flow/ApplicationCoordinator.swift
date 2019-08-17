import Combine
import SwiftUI

enum StateCase {
    case authenticated
    case login
}

typealias People = [Person]
struct Person: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
}

protocol Coordinator: AnyObject {
    func start() -> AnyView
}

final class ApplicationCoordinator: ObservableObject, Coordinator {
    private let peopleData = [
        ("Kirby Lumsden", 25),
        ("Petra Wiersma", 18),
        ("Rachel Roth", 35),
        ("Stephenie Schwandt", 56),
        ("Marielle Queener", 72),
        ("Kelsi Mcclane", 43),
        ("Cira Pender", 28),
        ("Ingeborg Mynatt", 64),
        ("Signe Perrine", 12),
        ("Elvera Pelayo", 32)
    ]

    
    @Published var stateCase: StateCase
    let people: People
    
    // MARK: - Init
    init() {
        self.stateCase = .login
        self.people = peopleData.map { p in Person(name: p.0, age: p.1) }
    }
    
    func start() -> AnyView {
        guard stateCase == .authenticated else {
            return AuthenticationView(coordinator: self).any
        }
        
        return MyProfileView(coordinator: self).any
    }
    
    func selectPerson<Label>(_ person: Person, @ViewBuilder viewBuilder: () -> Label) -> NavigationLink<Label, AnyView> where Label: View {
        let userProfileView = UserProfileView(person: person).any
        let navigationLink = NavigationLink(destination: userProfileView, label: viewBuilder)
        
        return navigationLink
    }
    
    func logout() {
        self.stateCase = .login
    }
    
    func login() {
        self.stateCase = .authenticated
    }
}
