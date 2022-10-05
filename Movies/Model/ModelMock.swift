import RealmSwift
import Foundation

class ModelMock: Model {
    let mockRealm = try? Realm()
    var mockSortAscending: Bool = true
    static var mockMovieObjects: Results<MovieObject>?
    
    var isFillUpMovieObjectsCalled: Bool = false
    var fillUpMovieObjectsCalledCount: Int = 0
    
    var isRatingSortCalled: Bool = false
    var ratingSortCalledCount: Int = 0
    
    override func fillUpMovieObjects() {
        isFillUpMovieObjectsCalled = true
        fillUpMovieObjectsCalledCount += 1
        ModelMock.mockMovieObjects = realm?.objects(MovieObject.self)
    }
    
    override func ratingSort() {
        isRatingSortCalled = true
        ratingSortCalledCount += 1
        ModelMock.mockMovieObjects = ModelMock.mockMovieObjects?.sorted(byKeyPath: "rating", ascending: sortAscending)
    }
}
