import SwiftUI

struct SavedView: View {
    @Binding var path: NavigationPath
    @Binding var focusedRecipeID: String?
    @Environment(FavouriteStore.self) private var store
    @FocusState private var focusedID: String?

    private var saved: [Recipe] {
        store.savedRecipes()
    }

    var body: some View {
        Group {
            if saved.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Nothing saved yet")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundStyle(HearthColor.cream)
                    Text("Open a recipe and press Save. It stays on this Apple TV after you close the app.")
                        .font(.system(size: 30))
                        .foregroundStyle(HearthColor.cream.opacity(0.72))
                        .frame(maxWidth: 900, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(64)
                .accessibilityIdentifier("saved.empty")
            } else {
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: HearthSpace.cardWidth), spacing: 36)],
                        alignment: .leading,
                        spacing: 36
                    ) {
                        ForEach(saved) { recipe in
                            VStack(alignment: .leading, spacing: 16) {
                                RecipeButton(
                                    recipe: recipe,
                                    path: $path,
                                    focusedRecipeID: $focusedRecipeID
                                )
                                .focused($focusedID, equals: recipe.id)

                                Button("Remove") {
                                    store.remove(recipe.id)
                                }
                                .buttonStyle(HearthControlButtonStyle())
                                .accessibilityIdentifier("remove.\(recipe.id)")
                            }
                        }
                    }
                    .padding(64)
                }
                .onAppear {
                    focusedID = focusedRecipeID
                }
                .onChange(of: path.count) { _, count in
                    guard count == 0 else { return }
                    focusedID = focusedRecipeID
                }
            }
        }
        .navigationTitle("Saved")
    }
}
