import Foundation

enum AuthorsProviderError: Error {
    case unauthorized
    case unknown
}
    
protocol AuthorsProviderProtocol {
    typealias AuthorsProviderResult = Result<Authors, Error>
    
    func listAuthors(completion: @escaping (AuthorsProviderResult) -> Void)
}

final class AuthorsProvider: AuthorsProviderProtocol {
    func listAuthors(completion: @escaping (AuthorsProviderResult) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let authorsStore = AuthorsStore.makeDummyFulfilled
            completion(.success(authorsStore.authors))
        }
    }
}
