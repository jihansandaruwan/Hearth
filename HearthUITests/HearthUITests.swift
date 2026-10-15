import XCTest

final class HearthUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-ui-testing"]
        app.launch()
    }

    func testOpenRecipeSaveItThenRemoveIt() {
        let card = app.descendants(matching: .any)["recipe.pol"]
        XCTAssertTrue(card.waitForExistence(timeout: 8))
        card.tap()

        let save = app.buttons["favourite.toggle"]
        XCTAssertTrue(save.waitForExistence(timeout: 5))
        save.tap()
        XCTAssertTrue(app.descendants(matching: .any)["save.notice"].waitForExistence(timeout: 3))

        let saved = app.descendants(matching: .any)["section.saved"]
        XCTAssertTrue(saved.waitForExistence(timeout: 5))
        saved.tap()

        XCTAssertTrue(app.staticTexts["Pol sambol"].waitForExistence(timeout: 5))

        let remove = app.descendants(matching: .any)["remove.pol"]
        XCTAssertTrue(remove.waitForExistence(timeout: 5))
        remove.tap()

        XCTAssertTrue(app.staticTexts["Nothing saved yet"].waitForExistence(timeout: 5))
    }
}
