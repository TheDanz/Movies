import XCTest
@testable import Movies

final class MoviesTests: XCTestCase {
    var modelMock: ModelMock = ModelMock()
    
    func testFillUpMovieObjects() throws {
        modelMock.fillUpMovieObjects()
        XCTAssertTrue(modelMock.isFillUpMovieObjectsCalled)
        XCTAssertTrue(modelMock.fillUpMovieObjectsCalledCount == 1)
        XCTAssertTrue(!ModelMock.mockMovieObjects!.isEmpty)
    }
    
    func testRatingSort() throws {
        modelMock.ratingSort()
        XCTAssertTrue(modelMock.isRatingSortCalled)
        XCTAssertTrue(modelMock.ratingSortCalledCount == 1)
        
        for i in 0..<ModelMock.mockMovieObjects!.count - 1 {
            XCTAssertTrue(ModelMock.mockMovieObjects![i].rating <= ModelMock.mockMovieObjects![i + 1].rating)
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
