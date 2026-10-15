import Foundation

enum MealKind: String, CaseIterable, Identifiable {
    case quick
    case rice
    case sweet

    var id: String { rawValue }

    var title: String {
        switch self {
        case .quick: "Quick"
        case .rice: "Rice plate"
        case .sweet: "After dinner"
        }
    }
}

enum Plate: String {
    case coconut
    case dhal
    case curry
    case fish
    case hopper
    case roti
    case kottu
    case custard

    var symbol: String {
        switch self {
        case .coconut: "leaf.fill"
        case .dhal: "drop.fill"
        case .curry: "flame.fill"
        case .fish: "fish.fill"
        case .hopper: "circle.circle"
        case .roti: "circle.grid.2x2.fill"
        case .kottu: "fork.knife"
        case .custard: "cup.and.saucer.fill"
        }
    }
}

struct Recipe: Identifiable, Hashable {
    let id: String
    let name: String
    let summary: String
    let meal: MealKind
    /// Illustrative demo estimate, not a tested kitchen measurement.
    let prepMinutes: Int
    /// Illustrative demo estimate. Zero means the dish is not cooked.
    let cookMinutes: Int
    let serves: Int
    let plate: Plate
    let ingredients: [String]
    let steps: [String]

    var totalMinutes: Int { prepMinutes + cookMinutes }
    var imageName: String { "recipe-\(id)" }
}

enum HearthRoute: Hashable {
    case recipe(String)
    case cook(String)
}

enum HearthSection: String, CaseIterable, Identifiable {
    case shelves
    case saved

    var id: String { rawValue }

    var title: String {
        switch self {
        case .shelves: "Recipes"
        case .saved: "Saved"
        }
    }

    var symbol: String {
        switch self {
        case .shelves: "rectangle.grid.1x2"
        case .saved: "heart.fill"
        }
    }

    var accessibilityID: String {
        switch self {
        case .shelves: "section.recipes"
        case .saved: "section.saved"
        }
    }
}
