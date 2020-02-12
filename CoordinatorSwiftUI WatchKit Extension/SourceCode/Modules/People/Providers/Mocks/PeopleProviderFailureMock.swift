final class PeopleProviderFailureMock: PeopleProviderProtocol {
    func listPeople(completion: @escaping (PeopleProviderResult) -> Void) {
        completion(
            .failure(PeopleProviderError.unauthorized)
        )
    }
}
