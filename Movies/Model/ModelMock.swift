import RealmSwift
import Foundation

class ModelMock: Model {
    let mockRealm = try? Realm()
    var mockSortAscending: Bool = true
    static var mockMovieObjects: Results<MovieObject>?
    
    var isFillUpMovieObjectsCalled: Bool = false
    var fillUpMovieObjectsCalledCount: Int = 0
    
    override func fillUpMovieObjects() {
        isFillUpMovieObjectsCalled = true
        fillUpMovieObjectsCalledCount += 1
        Model.movieObjects = realm?.objects(MovieObject.self)
    }
}
