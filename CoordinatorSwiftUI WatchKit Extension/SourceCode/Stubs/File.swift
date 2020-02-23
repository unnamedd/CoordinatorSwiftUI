import Foundation

final class File {
    enum Extension: String {
        case json
        case txt
    }
    
    private init() {}
    
    static func load<T: Decodable>(type: T.Type = T.self, _ filename: String, _ ext: Extension = .json) throws -> T {
        let bundle = Bundle.main
        
        guard let url = bundle.url(forResource: filename, withExtension: ext.rawValue) else {
            fatalError("Error: File '\(filename).\(ext.rawValue)' doesn't exist")
        }
        
        let data = try Data(contentsOf: url)
        let content = try JSONDecoder().decode(type, from: data)
        
        return content
    }
}
