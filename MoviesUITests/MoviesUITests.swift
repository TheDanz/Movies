import XCTest

final class MoviesUITests: XCTestCase {
    func testExsitingElementsOnMainViewController() throws {
        let app = XCUIApplication()
        app.launch()
        
        let moviesNavigationBar = app.navigationBars["Movies"]
        XCTAssert(moviesNavigationBar.exists)
        XCTAssert(moviesNavigationBar.staticTexts["Movies"].exists)
        XCTAssert(moviesNavigationBar.searchFields["Найти фильм"].exists)
        XCTAssert(moviesNavigationBar.buttons["Item"].exists)
    }
    
    func testMovieDetailsViewExistsAfterClickOnCollectionView() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        
        XCTAssert(app.otherElements["MovieDetailsView"].exists)
    }
}
