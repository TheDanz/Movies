import Foundation
import RealmSwift

class JSONParsingService {
    func parseJSON(parseData: Data, parseError: Error?) {
        do {
            let movieObject = try JSONDecoder().decode(MovieList.self, from: parseData)
            let JSONObjects = movieObject.results
            let realm = try? Realm()
            
            try realm?.write({
                for item in JSONObjects {
                    let object = MovieObject()
                    if let unwrID = item.id,
                       let unwrPoster = item.poster_path,
                       let unwrOrigTitle = item.original_title,
                       let unwrAbout = item.overview,
                       let unwrReleaseYear = item.release_date,
                       let unwrFilmRating = item.vote_average {
                          object.id = unwrID
                          object.picture = unwrPoster
                          object.title = unwrOrigTitle
                          object.about = unwrAbout
                          object.releaseYear = Int(unwrReleaseYear.prefix(4)) ?? 0000
                          object.rating = unwrFilmRating
                          //object.screenshots = item.backdrop_path ?? "N/A"
                          object.isLiked = false
                    }
                    realm?.add(object, update: .all)
                }
            })
        } catch let error {
            print(error)
        }
    }
}
