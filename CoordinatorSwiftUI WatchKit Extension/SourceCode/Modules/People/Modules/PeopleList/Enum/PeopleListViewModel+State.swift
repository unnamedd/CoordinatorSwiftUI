extension PeopleListViewModel {
    enum State {
        case initial
        case error
        case list
        case loading
    }
}

extension PeopleListViewModel.State: CustomStringConvertible {
    var description: String {
        switch self {
            case .loading, .initial:
                return "Loading..."
            
            case .error:
                return "Something went wrong"
            
            case .list:
                return ""
        }
    }
}
