import RealmSwift
import Foundation

class MovieObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var picture: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var about: String = ""
    @objc dynamic var releaseYear: Int = 0
    @objc dynamic var rating: Double = 0
    dynamic var screenshots: List<String> = List<String>()
    @objc dynamic var isLiked: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class LikedMovieObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var picture: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var about: String = ""
    @objc dynamic var releaseYear: Int = 0
    @objc dynamic var rating: Double = 0
    dynamic var screenshots: List<String> = List<String>()
    @objc dynamic var isLiked: Bool = true
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
