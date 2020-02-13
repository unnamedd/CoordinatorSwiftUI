import SwiftUI
import Combine

final class PeopleStore: ObservableObject {
    @Published
    private(set) var people: People = []
    
    func updatePeople(_ people: People) {
        self.people = people
    }
    
    func updatePerson(_ person: Person) {
        guard let index = people.firstIndex(where: { $0.id == person.id }) else {
            return
        }
        
        people[index] = person
    }
    
    func deletePerson(at index: Int) {
        people.remove(at: index)
    }
}

// MARK: - Dummy

#if DEBUG

extension PeopleStore {
    static var makeDummyFulfilled: PeopleStore {
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
        
        let people = data.map {
            Person(
                name: $0.0,
                age: $0.1,
                biography: $0.2,
                isAuthor: $0.3
            )
        }
        
        let peopleStore = PeopleStore()
        peopleStore.updatePeople(people)
        
        return peopleStore
    }
    
    static var makeDummyEmpty: PeopleStore {
        let peopleStore = PeopleStore()
        
        return peopleStore
    }
}


#endif
