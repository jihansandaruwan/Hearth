import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RecipePhoto(name: recipe.imageName)
                .frame(height: 188)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            Text(recipe.meal.title.uppercased())
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(HearthColor.turmeric)
            Text(recipe.name)
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(HearthColor.cream)
                .lineLimit(2)
            Text(recipe.summary)
                .font(.system(size: 22))
                .foregroundStyle(HearthColor.cream.opacity(0.78))
                .lineLimit(3)
                .frame(minHeight: 84, alignment: .topLeading)
            Text("\(recipe.totalMinutes) min · demo estimate")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(HearthColor.cream.opacity(0.9))
        }
        .padding(24)
        .frame(width: HearthSpace.cardWidth, alignment: .leading)
        .background(HearthColor.card, in: RoundedRectangle(cornerRadius: HearthSpace.radius, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

struct RecipeButton: View {
    let recipe: Recipe
    @Binding var path: NavigationPath
    @Binding var focusedRecipeID: String?

    var body: some View {
        Button {
            focusedRecipeID = recipe.id
            path.append(HearthRoute.recipe(recipe.id))
        } label: {
            RecipeCard(recipe: recipe)
        }
        .buttonStyle(HearthCardButtonStyle())
        .accessibilityIdentifier("recipe.\(recipe.id)")
    }
}
