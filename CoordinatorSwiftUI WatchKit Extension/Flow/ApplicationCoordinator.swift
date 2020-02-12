import Combine
import SwiftUI

enum StateCase {
    case authenticated
    case login
}

typealias People = [Person]
struct Person {
    let identifier = UUID()
    let name: String
    let age: Int
    let biography: String
}

extension People {
    static var makeDummy: People {
        let data = [
            ("Kirby Lumsden", 25, "Suspendisse sit amet ipsum et arcu iaculis sagittis."),
            ("Petra Wiersma", 18, "Curabitur consequat ipsum porta, cursus erat sed, volutpat augue."),
            ("Rachel Roth", 35, "Cras sed neque iaculis, tincidunt purus a, laoreet quam."),
            ("Stephenie Schwandt", 56, "Cras egestas orci ut magna dapibus, posuere consectetur mi fermentum."),
            ("Marielle Queener", 72, "Vestibulum sed leo congue, iaculis urna ut, accumsan lorem."),
            ("Kelsi Mcclane", 43, "Curabitur sit amet mi ut erat porta posuere nec quis est."),
            ("Cira Pender", 28, "Praesent sed felis eu nisl condimentum varius eget sit amet dui."),
            ("Ingeborg Mynatt", 64, "Nullam dictum arcu et sapien vulputate, a dictum eros maximus."),
            ("Signe Perrine", 12, "Suspendisse faucibus metus quis libero finibus, in hendrerit eros fringilla."),
            ("Elvera Pelayo", 32, "Ut bibendum odio pretium ex lacinia, non ullamcorper nulla accumsan.")
        ]
        
        let people = data.map {
            Person(
                name: $0.0,
                age: $0.1,
                biography: $0.2
            )
        }
        
        return people
    }
}

protocol Coordinator: AnyObject {
    func start() -> AnyView
}

final class ApplicationCoordinator: ObservableObject, Coordinator {
    @Published var stateCase: StateCase
    @Published var people: People
    
    // MARK: - Init
    init() {
        self.stateCase = .login
        self.people = People.makeDummy
    }
    
    func start() -> AnyView {
        guard stateCase == .authenticated else {
            return AuthenticationView(
                coordinator: self
            ).any
        }
        
        return MyProfileView(
            coordinator: self
        ).any
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

// MARK: - Dummy

#if DEBUG

extension ApplicationCoordinator {
    static func makeDummy() -> ApplicationCoordinator {
        ApplicationCoordinator()
    }
}

#endif
