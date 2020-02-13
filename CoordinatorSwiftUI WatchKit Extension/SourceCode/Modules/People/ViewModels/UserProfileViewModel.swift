import SwiftUI

final class UserProfileViewModel: ObservableObject {
    private var peopleStore: PeopleStore
    
    @Published
    private var person: Person
    
    var fullname: String {
        person.name
    }
    
    var userAge: Int {
        person.age
    }
    
    var biographyDescription: String {
        person.biography
    }
 
    var isAuthor: Bool {
        person.isAuthor
    }
    
    init(person: Person, store: PeopleStore) {
        self.peopleStore = store
        self.person = person
    }
    
    func updateAuthor(_ isAuthor: Bool) {
        self.person = self.person.updating(\.isAuthor, to: isAuthor)
        peopleStore.updatePerson(person)
    }
}

// MARK: - Dummy

#if DEBUG

extension UserProfileViewModel {
    static var makeDummy: UserProfileViewModel {
        let peopleStore = PeopleStore.makeDummyFulfilled
        let person = peopleStore.people[5]
        
        return UserProfileViewModel(
            person: person,
            store: peopleStore
        )
    }
}

#endif
