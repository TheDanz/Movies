import RealmSwift
import Foundation

class MovieObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var picture: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var releaseYear: Int = 0
    @objc dynamic var rating: Double = 0
    @objc dynamic var isLiked: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}