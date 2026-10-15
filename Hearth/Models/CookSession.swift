import Foundation

/// Step position for the cooking screen. The view draws it; tests move it.
struct CookSession: Equatable {
    let stepCount: Int
    private(set) var index: Int

    init(stepCount: Int) {
        self.stepCount = max(0, stepCount)
        index = 0
    }

    var isFirst: Bool { index <= 0 }
    var isLast: Bool { stepCount == 0 || index >= stepCount - 1 }
    var displayStep: Int { stepCount == 0 ? 0 : index + 1 }

    var progress: Double {
        guard stepCount > 0 else { return 0 }
        return Double(index + 1) / Double(stepCount)
    }

    mutating func advance() {
        guard !isLast else { return }
        index += 1
    }

    mutating func retreat() {
        guard !isFirst else { return }
        index -= 1
    }

    func stepText(in steps: [String]) -> String {
        guard steps.indices.contains(index) else {
            return "This demo has no steps."
        }
        return steps[index]
    }
}
