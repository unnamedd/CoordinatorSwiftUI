import Foundation

final class AuthorsProviderFailureMock: AuthorsProviderProtocol {

    func listAuthors(completion: @escaping (AuthorsProviderResult) -> Void) {
        completion(
            .failure(.unauthorized)
        )
    }

    func authorDetails(for identifier: String, completion: @escaping (AuthorProviderResult) -> Void) {
        completion(
            .failure(.notFound)
        )
    }
    
}
