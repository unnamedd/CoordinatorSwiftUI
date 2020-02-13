import SwiftUI

final class PeopleListViewModel: ObservableObject {
    private var provider: PeopleProviderProtocol
    
    @ObservedObject
    private var peopleStore: PeopleStore
    
    @Published
    private(set) var state: PeopleListViewModel.State = .initial
    
    var people: People {
        peopleStore.people
    }
    
    init(provider: PeopleProviderProtocol, store: PeopleStore) {
        self.provider = provider
        self.peopleStore = store
    }
    
    func loadPeople() {
        state = .loading
        
        provider.listPeople { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
                case .success(let people):
                    self.state = .list
                    self.peopleStore.updatePeople(people)
                
                case .failure:
                    self.state = .error
            }
        }
    }
    
    func refreshList() {
        objectWillChange.send()
    }
    
    func deletePerson(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        
        _ = withAnimation {
            self.peopleStore.deletePerson(at: index)
            objectWillChange.send()
        }
    }
}

#if DEBUG

extension PeopleListViewModel {
    static var makeSuccessDummy: PeopleListViewModel {
        let viewModel = PeopleListViewModel(
            provider: PeopleProviderSuccessMock(),
            store: PeopleStore.makeDummyFulfilled
        )
        
        viewModel.state = .initial
        
        return viewModel
    }
    
    static var makeFailureDummy: PeopleListViewModel {
        return PeopleListViewModel(
            provider: PeopleProviderFailureMock(),
            store: PeopleStore.makeDummyEmpty
        )
    }
}

#endif
