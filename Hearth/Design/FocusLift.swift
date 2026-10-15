import SwiftUI

/// tvOS reads focus on the button style, then scales the card and draws the yellow edge.
struct HearthCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        FocusedCard(isPressed: configuration.isPressed) {
            configuration.label
        }
    }
}

private struct FocusedCard<Content: View>: View {
    @Environment(\.isFocused) private var isFocused
    var isPressed: Bool
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .scaleEffect(isPressed ? 1.02 : (isFocused ? 1.06 : 1))
            .overlay {
                RoundedRectangle(cornerRadius: HearthSpace.radius, style: .continuous)
                    .strokeBorder(HearthColor.turmeric, lineWidth: isFocused ? 6 : 0)
            }
            .shadow(color: HearthColor.turmeric.opacity(isFocused ? 0.32 : 0), radius: isFocused ? 22 : 0, y: isFocused ? 10 : 0)
            .animation(.spring(response: 0.32, dampingFraction: 0.76), value: isFocused)
            .animation(.easeOut(duration: 0.12), value: isPressed)
    }
}

/// Filters, Save, Previous, Next, and Remove. Focus fills the control gold.
struct HearthControlButtonStyle: ButtonStyle {
    var isOn = false

    func makeBody(configuration: Configuration) -> some View {
        FocusedControl(isOn: isOn, isPressed: configuration.isPressed) {
            configuration.label
        }
    }
}

private struct FocusedControl<Content: View>: View {
    @Environment(\.isFocused) private var isFocused
    @Environment(\.isEnabled) private var isEnabled
    var isOn: Bool
    var isPressed: Bool
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .font(.system(size: 26, weight: .semibold))
            .padding(.horizontal, 28)
            .padding(.vertical, 14)
            .foregroundStyle(isFocused ? HearthColor.ink : HearthColor.cream)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(fill)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(HearthColor.turmeric, lineWidth: isFocused || isOn ? 4 : 0)
            }
            .opacity(isEnabled ? 1 : 0.38)
            .scaleEffect(isPressed ? 0.96 : (isFocused ? 1.05 : 1))
            .animation(.easeOut(duration: 0.16), value: isFocused)
    }

    private var fill: Color {
        if isFocused { return HearthColor.turmeric }
        if isOn { return HearthColor.turmeric.opacity(0.28) }
        return Color.white.opacity(0.10)
    }
}

struct RecipePhoto: View {
    let name: String
    var introduces = false
    @State private var shown = false

    var body: some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .opacity(introduces && !shown ? 0.01 : 1)
            .scaleEffect(introduces && !shown ? 0.96 : 1)
            .onAppear {
                guard introduces else { return }
                withAnimation(.easeOut(duration: 0.45)) {
                    shown = true
                }
            }
            .accessibilityHidden(true)
    }
}

struct PlateView: View {
    let plate: Plate

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(HearthColor.wash(plate))
            Circle()
                .fill(Color.white.opacity(0.14))
                .padding(36)
            Image(systemName: plate.symbol)
                .font(.system(size: 64, weight: .semibold))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(HearthColor.cream)
        }
        .accessibilityHidden(true)
    }
}
