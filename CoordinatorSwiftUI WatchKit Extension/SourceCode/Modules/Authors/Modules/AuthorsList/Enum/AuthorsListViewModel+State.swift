extension AuthorsListViewModel {
    enum State {
        case initial
        case error
        case list
        case loading
    }
}

extension AuthorsListViewModel.State: CustomStringConvertible {
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
