import XCTest

/// tvOS has no tap. These tests drive the app with the Siri Remote, like a person on the sofa.
final class HearthUITests: XCTestCase {
    let app = XCUIApplication()
    let remote = XCUIRemote.shared

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-ui-testing"]
        app.launch()
    }

    func testOpenRecipeSaveItAndComeBackToTheSameCard() {
        let card = app.buttons["recipe.pol"]
        XCTAssertTrue(card.waitForExistence(timeout: 8))
        XCTAssertTrue(waitForFocus(card))
        remote.press(.select)

        let save = app.buttons["favourite.toggle"]
        XCTAssertTrue(save.waitForExistence(timeout: 5))
        XCTAssertTrue(moveFocus(to: save, pressing: .right))
        remote.press(.select)
        XCTAssertTrue(app.staticTexts["save.notice"].waitForExistence(timeout: 3))

        remote.press(.menu)
        XCTAssertTrue(card.waitForExistence(timeout: 5))
        XCTAssertTrue(waitForFocus(card))
    }

    func testCookingRunsToDoneAndReturnsToTheRecipe() {
        let card = app.buttons["recipe.pol"]
        XCTAssertTrue(card.waitForExistence(timeout: 8))
        XCTAssertTrue(waitForFocus(card))
        remote.press(.select)

        let start = app.buttons["cook.start"]
        XCTAssertTrue(start.waitForExistence(timeout: 5))
        XCTAssertTrue(moveFocus(to: start, pressing: .left))
        remote.press(.select)

        XCTAssertTrue(app.buttons["cook.next"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["cook.previous"].isEnabled)

        for _ in 0..<3 {
            remote.press(.select)
        }
        let done = app.buttons["cook.done"]
        XCTAssertTrue(done.waitForExistence(timeout: 3))
        XCTAssertTrue(waitForFocus(done))
        remote.press(.select)

        XCTAssertTrue(app.buttons["favourite.toggle"].waitForExistence(timeout: 5))
    }

    private func waitForFocus(_ element: XCUIElement, timeout: TimeInterval = 5) -> Bool {
        let focused = XCTNSPredicateExpectation(predicate: NSPredicate(format: "hasFocus == true"), object: element)
        return XCTWaiter().wait(for: [focused], timeout: timeout) == .completed
    }

    private func moveFocus(to element: XCUIElement, pressing direction: XCUIRemote.Button, tries: Int = 4) -> Bool {
        for _ in 0..<tries {
            if element.hasFocus { return true }
            remote.press(direction)
        }
        return waitForFocus(element, timeout: 2)
    }
}
