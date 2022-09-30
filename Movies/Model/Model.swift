import RealmSwift
import UIKit

class Model {
    let realm = try? Realm()
    var arrayHelper: Results<MovieObject>?
    var sortAscending: Bool = true
    static var movieObjects: Results<MovieObject>?
    var likedMovieObjects: Results<LikedMovieObject>? {
        return realm?.objects(LikedMovieObject.self)
    }
    var sourceURL: String = "https://image.tmdb.org/t/p/original"

    func updateLike(at item: Int) {
        if let movie = Model.movieObjects?[item] {
            let object = LikedMovieObject()
                do {
                    try realm?.write ({
                        object.id = movie.id
                        object.picture = movie.picture
                        object.title = movie.title
                        object.about = movie.about
                        object.releaseYear = movie.releaseYear
                        object.rating = movie.rating
                        
                        realm?.add(object, update: .all)
                    })
            } catch {
                print(error)
            }
        }
    }
    
    func deleteLikedItem(at item: Int) {
        do {
            try realm?.write({
                if let likedObject = likedMovieObjects?[item] {
                    if let objects = likedMovieObjects {
                        for object in objects {
                            if object.id == likedObject.id {
                                realm?.delete(object)
                                break
                            }
                        }
                    }
                }
            })
        } catch {
            print(error)
        }
    }
    
    func ratingSort() {
        arrayHelper = Model.movieObjects?.sorted(byKeyPath: "rating", ascending: sortAscending)
    }
    
    func fillUpMovieObjects() {
        Model.movieObjects = realm?.objects(MovieObject.self)
    }
    
    func search(searchTextValue: String) {
        let predicate = NSPredicate(format: "title CONTAINS [c]%@", searchTextValue)
        Model.movieObjects = Model.movieObjects?.filter(predicate)
    }
}
