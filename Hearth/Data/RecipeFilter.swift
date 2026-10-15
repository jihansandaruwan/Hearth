import Foundation

enum RecipeFilter {
    static func recipes(in all: [Recipe], meal: MealKind?) -> [Recipe] {
        guard let meal else { return all }
        return all.filter { $0.meal == meal }
    }

    /// Shelves follow the meal order, and an empty meal is left out.
    static func shelves(in all: [Recipe], meal: MealKind?) -> [(meal: MealKind, recipes: [Recipe])] {
        let source = recipes(in: all, meal: meal)
        return MealKind.allCases.compactMap { kind in
            let items = source.filter { $0.meal == kind }
            return items.isEmpty ? nil : (kind, items)
        }
    }
}
