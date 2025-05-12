import XCTest

final class FakeNFTUITests: XCTestCase {
    func cartNFTUITest() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars.buttons["Корзина"].tap()
    }
}
