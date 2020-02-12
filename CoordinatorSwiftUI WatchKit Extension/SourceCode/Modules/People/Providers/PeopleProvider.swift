import Foundation

enum PeopleProviderError: Error {
    case noPeopleFound
    case unauthorized
    case unknown
}
    
protocol PeopleProviderProtocol {
    typealias PeopleProviderResult = Result<People, Error>
    
    func listPeople(completion: @escaping (PeopleProviderResult) -> Void)
}

final class PeopleProvider: PeopleProviderProtocol {
    func listPeople(completion: @escaping (PeopleProviderResult) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(People.makeDummy))
        }
    }
}
