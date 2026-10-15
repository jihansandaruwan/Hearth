import SwiftUI

struct CookView: View {
    let recipeID: String
    @State private var session: CookSession
    @Environment(\.dismiss) private var dismiss

    init(recipeID: String) {
        self.recipeID = recipeID
        let count = RecipeBook.recipe(id: recipeID)?.steps.count ?? 0
        _session = State(initialValue: CookSession(stepCount: count))
    }

    var body: some View {
        if let recipe = RecipeBook.recipe(id: recipeID) {
            cook(recipe)
        } else {
            Text("That recipe is missing.")
                .font(.title)
                .foregroundStyle(HearthColor.cream)
        }
    }

    private func cook(_ recipe: Recipe) -> some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(alignment: .center, spacing: 28) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(HearthColor.turmeric)
                    Text("Step \(session.displayStep) of \(session.stepCount)")
                        .font(.system(size: 28))
                        .foregroundStyle(HearthColor.cream.opacity(0.72))
                }
                Spacer()
                RecipePhoto(name: recipe.imageName, introduces: true)
                    .frame(width: 280, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
            ProgressView(value: session.progress)
                .tint(HearthColor.turmeric)
            Text(session.stepText(in: recipe.steps))
                .font(.system(size: 52, weight: .medium))
                .foregroundStyle(HearthColor.cream)
                .frame(maxWidth: 1400, alignment: .leading)
                .lineSpacing(10)
                .id(session.index)
            Spacer()
            HStack(spacing: 24) {
                Button("Previous") {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        session.retreat()
                    }
                }
                .disabled(session.isFirst)
                .buttonStyle(HearthControlButtonStyle())
                .accessibilityIdentifier("cook.previous")

                // One button, so focus stays put when Next turns into Done.
                Button(session.isLast ? "Done" : "Next") {
                    if session.isLast {
                        dismiss()
                    } else {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            session.advance()
                        }
                    }
                }
                .buttonStyle(HearthControlButtonStyle(isOn: true))
                .accessibilityIdentifier(session.isLast ? "cook.done" : "cook.next")
            }
            .focusSection()
        }
        .padding(80)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .animation(.easeInOut(duration: 0.2), value: session.index)
        .navigationTitle("Cooking")
    }
}
