import SwiftUI

struct ShelfHomeView: View {
    @Binding var path: NavigationPath
    @Binding var focusedRecipeID: String?
    @State private var meal: MealKind?
    @FocusState private var focusedID: String?

    private var shelves: [(meal: MealKind, recipes: [Recipe])] {
        RecipeFilter.shelves(in: RecipeBook.all, meal: meal)
    }

    private var visibleIDs: [String] {
        shelves.flatMap(\.recipes).map(\.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 36) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("What are we cooking?")
                        .font(.system(size: 58, weight: .bold))
                        .foregroundStyle(HearthColor.cream)
                    Text("Home-style notes for the living-room screen.")
                        .font(.system(size: 28))
                        .foregroundStyle(HearthColor.cream.opacity(0.72))
                }

                mealRow

                if shelves.isEmpty {
                    emptyCategory
                } else {
                    ForEach(shelves, id: \.meal) { shelf in
                        shelfRow(shelf.meal, recipes: shelf.recipes)
                    }
                }
            }
            .padding(64)
            .padding(.bottom, 48)
            .animation(.easeInOut(duration: 0.28), value: meal)
        }
        .modifier(PreferredFocus(focus: $focusedID, id: preferredID))
        .onAppear(perform: pointAtPreferred)
        .onChange(of: path.count) { _, count in
            guard count == 0 else { return }
            pointAtPreferred()
        }
        .onChange(of: meal) { _, _ in
            rememberVisibleCard()
        }
        .navigationTitle("Recipes")
    }

    private var preferredID: String? {
        if let focusedRecipeID, visibleIDs.contains(focusedRecipeID) {
            return focusedRecipeID
        }
        return visibleIDs.first
    }

    private func pointAtPreferred() {
        rememberVisibleCard()
        focusedID = preferredID
    }

    /// The filter keeps focus on its own button; only the remembered card changes.
    private func rememberVisibleCard() {
        if let id = preferredID {
            focusedRecipeID = id
        }
        if let focusedID, !visibleIDs.contains(focusedID) {
            self.focusedID = preferredID
        }
    }

    private var mealRow: some View {
        HStack(spacing: 18) {
            mealButton(title: "All", kind: nil)
            ForEach(MealKind.allCases) { kind in
                mealButton(title: kind.title, kind: kind)
            }
        }
        .focusSection()
    }

    private func mealButton(title: String, kind: MealKind?) -> some View {
        Button(title) {
            meal = kind
        }
        .buttonStyle(HearthControlButtonStyle(isOn: meal == kind))
        .accessibilityIdentifier(kind.map { "meal.\($0.rawValue)" } ?? "meal.all")
    }

    private func shelfRow(_ meal: MealKind, recipes: [Recipe]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(meal.title)
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(HearthColor.cream)
            Text("\(recipes.count) \(recipes.count == 1 ? "recipe" : "recipes")")
                .font(.system(size: 22))
                .foregroundStyle(HearthColor.cream.opacity(0.6))
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 32) {
                    ForEach(recipes) { recipe in
                        RecipeButton(recipe: recipe, path: $path, focusedRecipeID: $focusedRecipeID)
                            .focused($focusedID, equals: recipe.id)
                    }
                }
                .padding(.vertical, 36)
                .padding(.horizontal, 10)
                .focusSection()
            }
            .scrollClipDisabled()
        }
    }

    private var emptyCategory: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Nothing in \(meal?.title ?? "this category")")
                .font(.system(size: 40, weight: .semibold))
                .foregroundStyle(HearthColor.cream)
            Text("Choose All to see all eight recipes.")
                .font(.system(size: 26))
                .foregroundStyle(HearthColor.cream.opacity(0.72))
        }
        .padding(.top, 24)
        .accessibilityIdentifier("category.empty")
    }
}

/// defaultFocus needs a real id. An empty filter has nothing to focus.
private struct PreferredFocus: ViewModifier {
    var focus: FocusState<String?>.Binding
    var id: String?

    func body(content: Content) -> some View {
        if let id {
            let value: String? = id
            content.defaultFocus(focus, value)
        } else {
            content
        }
    }
}
