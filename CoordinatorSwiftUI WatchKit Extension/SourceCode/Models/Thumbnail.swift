import Foundation

struct Thumbnail: Codable {
    let url: String
    let width: Int
    let height: Int
    
    private enum CodingKeys: String, CodingKey {
        case url = "source"
        case width
        case height
    }
}
