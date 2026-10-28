import SwiftUI
import RealityKit

@main struct MyApp: App {
    init() {
        SpinComponent.registerComponent()
        SpinSystem.registerSystem()
    }

    var body: some SwiftUI.Scene {
        WindowGroup {
            ContentView()
        }
        #if os(visionOS)
        .windowStyle(.volumetric)
        #endif
    }
}
