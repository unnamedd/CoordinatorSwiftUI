import Foundation

enum AuthorsProviderError: Error {
    case notFound
    case unauthorized
    case unknown
}
    
protocol AuthorsProviderProtocol {
    typealias AuthorsProviderResult = Result<Authors, AuthorsProviderError>
    typealias AuthorProviderResult = Result<Author, AuthorsProviderError>
    
    func listAuthors(completion: @escaping (AuthorsProviderResult) -> Void)
    func authorDetails(for identifier: String, completion: @escaping (AuthorProviderResult) -> Void)
}

final class AuthorsProvider: AuthorsProviderProtocol {
    func listAuthors(completion: @escaping (AuthorsProviderResult) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let authorsStore = AuthorsStore.makeDummyFulfilled
            completion(.success(authorsStore.authors))
        }
    }
    
    func authorDetails(for identifier: String, completion: @escaping (AuthorProviderResult) -> Void) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let authorsStore = AuthorsStore.makeDummyFulfilled
            
            guard let author = authorsStore.authors.first(where: { $0.id == identifier}) else {
                completion(.failure(.notFound))
                return
            }
            
            completion(.success(author))
        }
    }
}
