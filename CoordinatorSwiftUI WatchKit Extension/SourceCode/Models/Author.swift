import Foundation

typealias Authors = [Author]

struct Author: Codable, Identifiable {
    let id: String
    let position: Int
    let name: String
    let minimumEstimatedSales: String
    let maximumEstimatedSales: String
    let originalLanguage: String
    let genreOrMajorWorks: String
    let numberOfBooks: String
    let nationality: String
    var canonical: String
    var thumbnail: Thumbnail?
    var wikipedia: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case position
        case name = "author"
        case minimumEstimatedSales = "minimum_estimated_sales"
        case maximumEstimatedSales = "maximum_estimated_sales"
        case originalLanguage = "original_language"
        case genreOrMajorWorks = "genre_or_major_works"
        case numberOfBooks = "number_of_books"
        case nationality
        case canonical
        case thumbnail
        case wikipedia
        case description
    }
}

extension Author: Equatable {
    static func == (lhs: Author, rhs: Author) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Author {
    var firstname: String {
        let names = name.split(separator: " ")
        
        guard let firstname = names.first else {
            return name
        }
        
        return String(firstname)
    }
    
    var lastname: String {
        let names = name.split(separator: " ")
        
        guard let firstname = names.last else {
            return name
        }
        
        return String(firstname)
    }
}
