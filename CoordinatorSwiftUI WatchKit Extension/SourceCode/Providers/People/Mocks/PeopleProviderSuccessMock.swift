final class PeopleProviderSuccessMock: PeopleProviderProtocol {
    func listPeople(completion: @escaping (PeopleProviderResult) -> Void) {
        completion(
            .success(
                [
                    Person(name: "Simon Dach", age: 23, biography: "No biography", isAuthor: true),
                    Person(name: "Otto Braun", age: 64, biography: "Public man", isAuthor: true)
                ]
            )
        )
    }
}
