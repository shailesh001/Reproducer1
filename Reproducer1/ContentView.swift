import SwiftUI
import RealityKit

struct ContentView: View {
    var body: some View {
        RealityView { content in
            let cube = ModelEntity(
                mesh: .generateBox(size: 0.5),
                materials: [SimpleMaterial(color: .blue, isMetallic: false)]
            )
            cube.components.set(SpinComponent())

            #if os(visionOS)
            cube.position = [0, 0, 0]
            #else
            // Place the cube in front of the default virtual camera.
            cube.position = [0, 0, -0.6]
            #endif

            content.add(cube)
        }
        #if !os(visionOS)
        .realityViewCameraControls(.orbit)
        #endif
    }
}

#Preview {
    ContentView()
}
