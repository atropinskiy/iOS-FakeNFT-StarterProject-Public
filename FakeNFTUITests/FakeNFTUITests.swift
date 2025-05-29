import XCTest

final class FakeNFTUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    /// Test empty cart
    func testEmptyCartShowsEmptyText() throws {
        app.tabBars.buttons["Корзина"].tap() /// Don't forget!!!
        
        let emptyText = app.staticTexts["Корзина пуста"]
        XCTAssertTrue(emptyText.waitForExistence(timeout: 20), "Текст 'Корзина пуста' отображается на экране")
    }
    
    /// Test cart with nfts
    func testNavigateToPaymentScreen() throws {
        app.tabBars.buttons["Корзина"].tap()
        
        let payButton = app.buttons["payButton"]
        XCTAssertTrue(payButton.waitForExistence(timeout: 2), "Кнопка 'К оплате' существует")
        
        payButton.tap()
        
        let paymentTitle = app.staticTexts["Выберите способ оплаты"]
        XCTAssertTrue(paymentTitle.waitForExistence(timeout: 2), "Открылся экран выбора валюты")
    }
    
    /// Test filter button
    func testNFTsFilter() throws {
        app.tabBars.buttons["Корзина"].tap()
        
        let sortButton = app.buttons.matching(identifier: "cartFilter").firstMatch
        XCTAssertTrue(sortButton.waitForExistence(timeout: 5), "Кнопка сортировки есть на экране")
        
        sortButton.tap()
        
        let dialogTitle = app.staticTexts["Сортировка"]
        XCTAssertTrue(dialogTitle.waitForExistence(timeout: 2), "Открылся экран сортировки")
        
        let priceOption = app.buttons["По цене"]
        XCTAssertTrue(priceOption.exists, "В меню фильтрации есть кнопка По цене")
    }
}
