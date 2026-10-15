import SwiftUI

/// Hearth is a tvOS recipe board for the living room.
/// Minimum tvOS is 17 because screens share an @Observable favourite store.
@main
struct HearthApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.dark)
                .tint(HearthColor.turmeric)
        }
    }
}
