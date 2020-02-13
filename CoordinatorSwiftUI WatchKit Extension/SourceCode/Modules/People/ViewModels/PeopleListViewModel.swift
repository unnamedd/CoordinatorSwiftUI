import SwiftUI

final class PeopleListViewModel: ObservableObject {
    private var provider: PeopleProviderProtocol
    
    @Published
    private(set) var state: PeopleListViewModel.State = .initial

    @Published
    private(set) var people: People = []
    
    init(provider: PeopleProviderProtocol) {
        self.provider = provider
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
                    self.people = people
                
                case .failure:
                    self.state = .error
            }
        }
    }
    
    func refreshList() {
        loadPeople()
    }
    
    func deletePerson(at indexSet: IndexSet) {
        guard let first = indexSet.first else {
            return
        }
        
        _ = withAnimation {
            self.people.remove(at: first)
        }
    }
}

#if DEBUG

extension PeopleListViewModel {
    static var makeSuccessDummy: PeopleListViewModel {
        return PeopleListViewModel(
            provider: PeopleProviderSuccessMock()
        )
    }
    
    static var makeFailureDummy: PeopleListViewModel {
        return PeopleListViewModel(
            provider: PeopleProviderFailureMock()
        )
    }
}

#endif
