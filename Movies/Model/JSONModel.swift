class MovieList: Codable {
    let page: Int
    let totalResults: Int?
    let totalPages: Int?
    let results: [Result]
}

class Result: Codable {
    var id: Int?
    var original_title: String?
    var poster_path: String?
    var release_date: String?
    var overview: String?
    var vote_average: Double?
    var backdrop_path: String?
}
