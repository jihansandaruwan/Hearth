import SwiftUI

struct RootView: View {
    @State private var section: HearthSection? = .shelves
    @State private var path = NavigationPath()
    @State private var focusedRecipeID: String?
    @State private var store: FavouriteStore

    init() {
        let store: FavouriteStore
        if ProcessInfo.processInfo.arguments.contains("-ui-testing") {
            let suite = "hearth.ui-tests"
            let defaults = UserDefaults(suiteName: suite) ?? .standard
            defaults.removePersistentDomain(forName: suite)
            store = FavouriteStore(defaults: defaults)
        } else {
            store = FavouriteStore()
        }
        _store = State(initialValue: store)
        _focusedRecipeID = State(initialValue: RecipeBook.all.first?.id)
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $section) {
                ForEach(HearthSection.allCases, id: \.self) { item in
                    Label(item.title, systemImage: item.symbol)
                        .tag(Optional(item))
                        .accessibilityIdentifier(item.accessibilityID)
                }
            }
            .navigationTitle("Hearth")
        } detail: {
            NavigationStack(path: $path) {
                detail
                    .navigationDestination(for: HearthRoute.self) { route in
                        switch route {
                        case .recipe(let id):
                            RecipeDetailView(recipeID: id)
                        case .cook(let id):
                            CookView(recipeID: id)
                        }
                    }
            }
        }
        .navigationSplitViewStyle(.balanced)
        .environment(store)
        .background(HearthColor.background)
        .onChange(of: section) { _, _ in
            path = NavigationPath()
        }
    }

    @ViewBuilder
    private var detail: some View {
        switch section ?? .shelves {
        case .shelves:
            ShelfHomeView(path: $path, focusedRecipeID: $focusedRecipeID)
        case .saved:
            SavedView(path: $path, focusedRecipeID: $focusedRecipeID)
        }
    }
}
