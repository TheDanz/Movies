import XCTest
@testable import Movies

final class MoviesTests: XCTestCase {
    var modelMock: ModelMock = ModelMock()
    
    func testFillUpMovieObjects() throws {
        modelMock.fillUpMovieObjects()
        XCTAssertTrue(modelMock.isFillUpMovieObjectsCalled)
        XCTAssertTrue(modelMock.fillUpMovieObjectsCalledCount == 1)
        XCTAssertTrue(!ModelMock.movieObjects!.isEmpty)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
