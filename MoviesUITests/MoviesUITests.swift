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
        let verticalScrollBar8PagesCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 8 pages").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 8 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(verticalScrollBar8PagesCollectionView.exists)
    }
}
