import SwiftUI

enum HearthColor {
    static let background = Color(red: 0.12, green: 0.12, blue: 0.13)
    static let card = Color(red: 0.18, green: 0.18, blue: 0.19)
    static let cream = Color(red: 0.96, green: 0.93, blue: 0.86)
    static let turmeric = Color(red: 0.95, green: 0.76, blue: 0.28)
    static let ink = Color(red: 0.12, green: 0.10, blue: 0.08)

    static func wash(_ plate: Plate) -> Color {
        switch plate {
        case .coconut: Color(red: 0.16, green: 0.46, blue: 0.32)
        case .dhal: Color(red: 0.78, green: 0.52, blue: 0.14)
        case .curry: Color(red: 0.70, green: 0.24, blue: 0.16)
        case .fish: Color(red: 0.16, green: 0.38, blue: 0.56)
        case .hopper: Color(red: 0.62, green: 0.42, blue: 0.16)
        case .roti: Color(red: 0.55, green: 0.36, blue: 0.20)
        case .kottu: Color(red: 0.58, green: 0.22, blue: 0.18)
        case .custard: Color(red: 0.46, green: 0.28, blue: 0.42)
        }
    }
}

enum HearthSpace {
    static let cardWidth: CGFloat = 440
    static let radius: CGFloat = 28
}

enum HearthCopy {
    static let demoTimes = "Amounts and times are illustrative demo values for this assignment. They are not tested kitchen measurements."
}
