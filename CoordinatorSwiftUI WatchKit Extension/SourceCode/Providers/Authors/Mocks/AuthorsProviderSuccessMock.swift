final class AuthorsProviderSuccessMock: AuthorsProviderProtocol {
    func listAuthors(completion: @escaping (AuthorsProviderResult) -> Void) {
        completion(
            .success(
                [
                    Author(name: "Simon Dach", age: 23, biography: "No biography", isEditor: true),
                    Author(name: "Otto Braun", age: 64, biography: "Public man", isEditor: true)
                ]
            )
        )
    }
}
