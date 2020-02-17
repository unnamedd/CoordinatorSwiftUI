import SwiftUI

final class ProfileDetailViewModel: ObservableObject {
    private var peopleStore: PeopleStore
    
    @Published
    private var person: Person
    
    var fullname: String {
        person.name
    }
    
    var firstname: String {
        let names = fullname.split(separator: " ")
        
        guard let firstname = names.first else {
            return fullname
        }
        
        return String(firstname)
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

extension ProfileDetailViewModel {
    static var makeDummy: ProfileDetailViewModel {
        let peopleStore = PeopleStore.makeDummyFulfilled
        let person = peopleStore.people[5]
        
        return ProfileDetailViewModel(
            person: person,
            store: peopleStore
        )
    }
}

#endif
