import RealmSwift
import UIKit

class Model {
    let realm = try? Realm()
    var arrayHelper: Results<MovieObject>?
    var sortAscending: Bool = true
    var movieObjects: Results<MovieObject>? {
        return realm?.objects(MovieObject.self)
    }
    var likedMovieObjects: Results<LikedMovieObject>? {
        return realm?.objects(LikedMovieObject.self)
    }
    var sourceURL: String = "https://image.tmdb.org/t/p/original"

    func updateLike(at item: Int) {
        var localChecker: [MovieObject] = []
        if let film = movieObjects?[item],
           let array = movieObjects{
            let object = LikedMovieObject()
                do {
                    try realm?.write ({
                        film.isLiked = !film.isLiked
                    
                        for i in array {
                            if i.isLiked == true {
                                localChecker.append(i)
                            }
                        }
                        
                        for el in localChecker {
                            object.id = el.id
                            object.picture = el.picture
                            object.title = el.title
                            object.about = el.about
                            object.releaseYear = el.releaseYear
                            object.rating = el.rating
                            
                            realm?.add(object, update: .all)
                        }
                    })
            } catch {
                print("Error saving done status, \(error)")
            }
        }
    }
    
    func deleteLikedItem(at item: Int) {
        do {
        try realm?.write({
        
            if let likedArray = likedMovieObjects, let likedObject = likedMovieObjects?[item] {
                likedObject.isLiked = !likedObject.isLiked
                
                for i in likedArray {
                    if i.isLiked == false {
                        realm?.delete(i)
                    }
                }
            }
            
        })
        } catch {
            print("Error saving done status, \(error)")
        }
    }
    
    func ratingSort() {
        arrayHelper = movieObjects?.sorted(byKeyPath: "rating", ascending: sortAscending)
    }
    
    func search(searchTextValue: String) {
        let predicate = NSPredicate(format: "title CONTAINS [c]%@", searchTextValue)
        arrayHelper = movieObjects?.filter(predicate)
    }
}
