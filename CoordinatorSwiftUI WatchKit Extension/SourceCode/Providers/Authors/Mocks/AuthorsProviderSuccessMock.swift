import Foundation

final class AuthorsProviderSuccessMock: AuthorsProviderProtocol {
    func listAuthors(completion: @escaping (AuthorsProviderResult) -> Void) {
        let authorsStub = Authors.makeDummy
        let firstAuthor = authorsStub[0]
        let secondAuthor = authorsStub[1]
        
        completion(
            .success([firstAuthor, secondAuthor])
        )
    }

    func authorDetails(for identifier: String, completion: @escaping (AuthorProviderResult) -> Void) {
        let authorsStub = Authors.makeDummy
        let firstAuthor = authorsStub[0]
        
        completion(
            .success(firstAuthor)
        )
    }
}
