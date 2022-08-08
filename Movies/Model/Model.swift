import RealmSwift
import UIKit

class Model {
    let realm = try? Realm()
    var sortedMovieObjects: Results<MovieObject>?
    var arrayHelper: Results<MovieObject>?
    var likedMovieObjects: Results<MovieObject>?
    var sortAscending: Bool = false
    var movieObjects: Results<MovieObject>? {
        return realm?.objects(MovieObject.self)
    }

    func updateLike(at item: Int) {
        if let movie = movieObjects?[item] {
            do {
                try realm?.write {
                    movie.isLiked = !movie.isLiked
                }
            }
            catch {
                print(error)
            }
        }
    }
    
    func ratingSort() {
        arrayHelper = movieObjects?.sorted(byKeyPath: "rating", ascending: sortAscending)
    }
    
    func showLikedItems() {
        let likeFilter = NSPredicate(format: "isLiked = true")
        likedMovieObjects = movieObjects?.filter(likeFilter)
    }
    
    func search(searchTextValue: String) {
        let predicate = NSPredicate(format: "title CONTAINS [c]%@", searchTextValue)
        arrayHelper = movieObjects?.filter(predicate)
    }
}
