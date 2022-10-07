import Foundation
import RealmSwift

extension JSONParsingService {
    class private func getBasicUrlComponent() -> URLComponents {
        guard let urlComponent = URLComponents(string: "https://api.themoviedb.org")
        else { fatalError("url error") }
        return urlComponent
    }
}

final internal class JSONParsingService {
    
    internal init() {
        self.basicUrlComponent = Self.getBasicUrlComponent()
        self.key = "de90f94f39c65c15d15b072e0ef2a493"
    }
    
    private let basicUrlComponent: URLComponents
    private let key: String
    
    private func save(realm: Realm?, movieObject: MovieObject){
        do {
            try realm?.write({
                realm?.add(movieObject, update: .all)
            })
        } catch let error {
            print(error)
        }
    }
    
    private func newMethod(parseData: Data, parseError: Error?){
        guard let movieObject = try? JSONDecoder().decode(MovieList.self, from: parseData)
        else { return }
        let realm = try? Realm()
        for item in movieObject.results {
            self.getMovieObject(item) { movieObject in
                guard let movieObject = movieObject else { return }
                self.save(realm: realm, movieObject: movieObject)
            }
        }
    }
    
    private func getMovieObject(_ item: Result, handler: @escaping (MovieObject?)->()) {
        let object = MovieObject()
        
        guard let unwrID = item.id,
              let unwrPoster = item.poster_path,
              let unwrOrigTitle = item.original_title,
              let unwrAbout = item.overview,
              let unwrReleaseYear = item.release_date,
              let unwrFilmRating = item.vote_average
        else {
            handler(nil)
            return
        }
        
        object.id = unwrID
        object.picture = unwrPoster
        object.title = unwrOrigTitle
        object.about = unwrAbout
        object.releaseYear = Int(unwrReleaseYear.prefix(4)) ?? 0000
        object.rating = unwrFilmRating
        
        var urlComponent = self.basicUrlComponent
        urlComponent.path = "/3/movie/\(unwrID)/images"
        urlComponent.queryItems = [URLQueryItem(name: "api_key", value: self.key)]
        
        guard let url = urlComponent.url else {
            handler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let unwrData = data, (response as? HTTPURLResponse)?.statusCode == 200,error == nil
            else {
                handler(nil)
                return
            }
            do {
                let result = try JSONDecoder().decode(Result.self, from: unwrData)
                let backdrops = result.backdrops
                
                if let unwrBackdrops = backdrops {
                    for backdrop in unwrBackdrops {
                        object.screenshots.append(backdrop.file_path ?? "N/A")
                    }
                    DispatchQueue.main.async {
                        handler(object)
                    }
                    return
                }
                handler(nil)
            } catch let error {
                print(error)
                handler(nil)
            }
        }.resume()
    }
    
    func parseJSON(parseData: Data, parseError: Error?) {
        DispatchQueue.main.async {
            self.newMethod(parseData: parseData, parseError: parseError)
        }
        return
    }
}

