final class AuthorsProviderFailureMock: AuthorsProviderProtocol {
    func listAuthors(completion: @escaping (AuthorsProviderResult) -> Void) {
        completion(
            .failure(AuthorsProviderError.unauthorized)
        )
    }
}
