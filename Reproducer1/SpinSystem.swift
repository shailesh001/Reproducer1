import RealityKit

/// Marks an entity to be rotated continuously around its Y axis.
struct SpinComponent: Component {
    var radiansPerSecond: Float = .pi / 2
}

/// Per-frame update loop: rotates every entity that has a `SpinComponent`.
struct SpinSystem: System {
    private static let query = EntityQuery(where: .has(SpinComponent.self))

    init(scene: Scene) {}

    func update(context: SceneUpdateContext) {
        let deltaTime = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard let spin = entity.components[SpinComponent.self] else { continue }
            let rotation = simd_quatf(angle: spin.radiansPerSecond * deltaTime, axis: [0, 1, 0])
            entity.orientation = rotation * entity.orientation
        }
    }
}
