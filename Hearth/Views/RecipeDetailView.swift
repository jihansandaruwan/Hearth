import SwiftUI

struct RecipeDetailView: View {
    let recipeID: String
    @Environment(FavouriteStore.self) private var store
    @State private var notice: String?

    var body: some View {
        if let recipe = RecipeBook.recipe(id: recipeID) {
            detail(recipe)
        } else {
            Text("That recipe is missing.")
                .font(.title)
                .foregroundStyle(HearthColor.cream)
        }
    }

    private func detail(_ recipe: Recipe) -> some View {
        ScrollView {
            HStack(alignment: .top, spacing: 56) {
                RecipePhoto(name: recipe.imageName, introduces: true)
                    .frame(width: 520, height: 520)
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

                VStack(alignment: .leading, spacing: 20) {
                    Text(recipe.meal.title.uppercased())
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(HearthColor.turmeric)
                    Text(recipe.name)
                        .font(.system(size: 58, weight: .bold))
                        .foregroundStyle(HearthColor.cream)
                    Text(recipe.summary)
                        .font(.system(size: 30))
                        .foregroundStyle(HearthColor.cream.opacity(0.8))

                    HStack(spacing: 28) {
                        timeBlock(title: "Prep", value: "\(recipe.prepMinutes) min")
                        timeBlock(
                            title: "Cook",
                            value: recipe.cookMinutes == 0 ? "No cooking" : "\(recipe.cookMinutes) min"
                        )
                        timeBlock(title: "Serves", value: "\(recipe.serves)")
                    }

                    Text("Ingredients")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(HearthColor.cream)
                        .padding(.top, 8)
                    LazyVGrid(
                        columns: [GridItem(.flexible(), alignment: .leading), GridItem(.flexible(), alignment: .leading)],
                        alignment: .leading,
                        spacing: 12
                    ) {
                        ForEach(recipe.ingredients, id: \.self) { item in
                            Text(item)
                                .font(.system(size: 24))
                                .foregroundStyle(HearthColor.cream.opacity(0.9))
                        }
                    }

                    Text(HearthCopy.demoTimes)
                        .font(.system(size: 22))
                        .foregroundStyle(HearthColor.cream.opacity(0.62))
                        .padding(.top, 4)

                    HStack(spacing: 20) {
                        NavigationLink(value: HearthRoute.cook(recipe.id)) {
                            Text("Start cooking")
                        }
                        .buttonStyle(HearthControlButtonStyle(isOn: true))
                        .accessibilityIdentifier("cook.start")

                        Button {
                            let removing = store.contains(recipe.id)
                            store.toggle(recipe.id)
                            notice = removing ? "Removed from Saved" : "Saved on this Apple TV"
                        } label: {
                            Label(
                                store.contains(recipe.id) ? "Saved" : "Save",
                                systemImage: store.contains(recipe.id) ? "heart.fill" : "heart"
                            )
                        }
                        .buttonStyle(HearthControlButtonStyle(isOn: store.contains(recipe.id)))
                        .accessibilityIdentifier("favourite.toggle")
                    }
                    .padding(.top, 8)
                    .focusSection()

                    if let notice {
                        Text(notice)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(HearthColor.turmeric)
                            .accessibilityIdentifier("save.notice")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(64)
        }
        .navigationTitle(recipe.name)
    }

    private func timeBlock(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(HearthColor.turmeric)
            Text(value)
                .font(.system(size: 26, weight: .semibold))
                .foregroundStyle(HearthColor.cream)
            Text("demo estimate")
                .font(.system(size: 16))
                .foregroundStyle(HearthColor.cream.opacity(0.5))
        }
    }
}
