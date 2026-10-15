import XCTest
@testable import Hearth

final class RecipeFilterTests: XCTestCase {
    func testAllReturnsEightRecipes() {
        let result = RecipeFilter.recipes(in: RecipeBook.all, meal: nil)
        XCTAssertEqual(result.map(\.id), ["pol", "roti", "kottu", "hopper", "dhal", "chicken", "ambul", "watalappan"])
    }

    func testQuickShelfKeepsFourRecipes() {
        let result = RecipeFilter.recipes(in: RecipeBook.all, meal: .quick)
        XCTAssertEqual(result.map(\.id), ["pol", "roti", "kottu", "hopper"])
    }

    func testRiceShelfKeepsOnlyRice() {
        let result = RecipeFilter.recipes(in: RecipeBook.all, meal: .rice)
        XCTAssertEqual(result.map(\.id), ["dhal", "chicken", "ambul"])
    }

    func testSweetShelfIsOnlyWatalappan() {
        let shelves = RecipeFilter.shelves(in: RecipeBook.all, meal: .sweet)
        XCTAssertEqual(shelves.map { $0.meal }, [.sweet])
        XCTAssertEqual(shelves.first?.recipes.map(\.id), ["watalappan"])
    }

    func testEmptyCategoryProducesNoShelf() {
        let quickOnly = RecipeBook.all.filter { $0.meal == .quick }
        let shelves = RecipeFilter.shelves(in: quickOnly, meal: .sweet)
        XCTAssertTrue(shelves.isEmpty)
    }

    func testUnknownRecipeIsNil() {
        XCTAssertNil(RecipeBook.recipe(id: "missing"))
    }

    func testLongerDishesHaveMoreSteps() {
        XCTAssertEqual(RecipeBook.recipe(id: "pol")?.steps.count, 4)
        XCTAssertEqual(RecipeBook.recipe(id: "kottu")?.steps.count, 4)
        XCTAssertEqual(RecipeBook.recipe(id: "hopper")?.steps.count, 6)
        XCTAssertEqual(RecipeBook.recipe(id: "chicken")?.steps.count, 6)
        XCTAssertEqual(RecipeBook.recipe(id: "watalappan")?.steps.count, 5)
    }

    func testPolIsUncookedDemo() {
        let pol = RecipeBook.recipe(id: "pol")
        XCTAssertEqual(pol?.prepMinutes, 15)
        XCTAssertEqual(pol?.cookMinutes, 0)
        XCTAssertEqual(pol?.totalMinutes, 15)
    }
}

final class FavouriteStoreTests: XCTestCase {
    private func makeStore() -> (FavouriteStore, UserDefaults, String) {
        let suite = "hearth.tests.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite) ?? UserDefaults.standard
        defaults.removePersistentDomain(forName: suite)
        return (FavouriteStore(defaults: defaults, key: "hearth.favourites"), defaults, suite)
    }

    func testToggleWritesRemovesAndReloads() {
        let (store, defaults, suite) = makeStore()
        defer { defaults.removePersistentDomain(forName: suite) }

        XCTAssertFalse(store.contains("pol"))
        store.toggle("pol")
        XCTAssertTrue(store.contains("pol"))
        XCTAssertEqual(store.savedRecipes().map(\.id), ["pol"])

        let reloaded = FavouriteStore(defaults: defaults, key: "hearth.favourites")
        XCTAssertTrue(reloaded.contains("pol"))

        reloaded.toggle("pol")
        XCTAssertFalse(reloaded.contains("pol"))
        XCTAssertTrue(reloaded.savedRecipes().isEmpty)
    }

    func testToggleDoesNotDuplicateAnID() {
        let (store, defaults, suite) = makeStore()
        defer { defaults.removePersistentDomain(forName: suite) }

        store.toggle("chicken")
        store.toggle("pol")
        store.toggle("pol")
        XCTAssertEqual(store.ids.count, 1)
        XCTAssertTrue(store.contains("chicken"))
        XCTAssertFalse(store.contains("pol"))
    }

    func testRemovePersists() {
        let (store, defaults, suite) = makeStore()
        defer { defaults.removePersistentDomain(forName: suite) }

        store.toggle("pol")
        store.toggle("dhal")
        store.remove("pol")

        let reloaded = FavouriteStore(defaults: defaults, key: "hearth.favourites")
        XCTAssertEqual(reloaded.savedRecipes().map(\.id), ["dhal"])
        reloaded.remove("missing")
        XCTAssertEqual(reloaded.savedRecipes().map(\.id), ["dhal"])
    }
}

final class CookSessionTests: XCTestCase {
    func testPreviousStaysOnTheFirstStep() {
        var session = CookSession(stepCount: 4)
        session.retreat()
        XCTAssertTrue(session.isFirst)
        XCTAssertEqual(session.displayStep, 1)
        XCTAssertFalse(session.isLast)
    }

    func testNextMovesAndDoneIsTheLastStep() {
        var session = CookSession(stepCount: 3)
        session.advance()
        XCTAssertEqual(session.displayStep, 2)
        session.advance()
        XCTAssertTrue(session.isLast)
        XCTAssertEqual(session.displayStep, 3)
        session.advance()
        XCTAssertEqual(session.index, 2)
        XCTAssertEqual(session.progress, 1)
    }

    func testBackFromTheMiddle() {
        var session = CookSession(stepCount: 4)
        session.advance()
        session.advance()
        session.retreat()
        XCTAssertEqual(session.displayStep, 2)
    }

    func testEmptyStepsDoNotCrash() {
        let session = CookSession(stepCount: 0)
        XCTAssertTrue(session.isFirst)
        XCTAssertTrue(session.isLast)
        XCTAssertEqual(session.progress, 0)
        XCTAssertEqual(session.stepText(in: []), "This demo has no steps.")
    }

    func testStepTextMatchesTheRecipe() {
        let steps = ["Slice the onion.", "Add lime."]
        var session = CookSession(stepCount: steps.count)
        XCTAssertEqual(session.stepText(in: steps), "Slice the onion.")
        session.advance()
        XCTAssertEqual(session.stepText(in: steps), "Add lime.")
    }
}
