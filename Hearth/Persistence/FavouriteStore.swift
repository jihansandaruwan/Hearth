import Foundation

/// Saved recipe ids. UserDefaults is enough because the list is only strings.
@Observable
final class FavouriteStore {
    private let defaults: UserDefaults
    private let key: String
    private(set) var ids: Set<String>

    init(defaults: UserDefaults = .standard, key: String = "hearth.favourites") {
        self.defaults = defaults
        self.key = key
        ids = Set(defaults.stringArray(forKey: key) ?? [])
    }

    func contains(_ id: String) -> Bool {
        ids.contains(id)
    }

    func toggle(_ id: String) {
        var next = ids
        if next.contains(id) {
            next.remove(id)
        } else {
            next.insert(id)
        }
        write(next)
    }

    func remove(_ id: String) {
        guard ids.contains(id) else { return }
        var next = ids
        next.remove(id)
        write(next)
    }

    private func write(_ next: Set<String>) {
        ids = next
        defaults.set(next.sorted(), forKey: key)
    }

    func savedRecipes(in all: [Recipe] = RecipeBook.all) -> [Recipe] {
        all.filter { ids.contains($0.id) }
    }
}
