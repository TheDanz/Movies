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
                        
                        var backdropsArray: [String] = []
                        guard let APIURL: URL = URL(string: "https://api.themoviedb.org/3/movie/\(unwrID)/images?api_key=de90f94f39c65c15d15b072e0ef2a493") else { return }
                        let task = URLSession.shared.dataTask(with: APIURL) { data, response, error in
                            guard let unwrData = data,
                                  (response as? HTTPURLResponse)?.statusCode == 200,
                                  error == nil else { return }
                            do {
                                let result = try JSONDecoder().decode(Result.self, from: unwrData)
                                let backdrops = result.backdrops

                                if let unwrBackdrops = backdrops {
                                    for backdrop in unwrBackdrops {
                                        print(backdrop.file_path ?? "N/A")
                                        backdropsArray.append(backdrop.file_path ?? "N/A")
                                    }
                                }
                            } catch let error {
                                print(error)
                            }
                        }
                        task.resume()
                        
                        print(backdropsArray)
                        object.screenshots.append(objectsIn: backdropsArray)
                        
                        
                        //object.isLiked = newOne.isLiked
                       }
                    realm?.add(object, update: .all)
                }
            })
        } catch let error {
            print(error)
        }
    }
}

