import RealityKit

/// Marks an entity to be rotated continuously around a local axis.
/// The default axis runs corner to corner through the cube (its body diagonal).
struct SpinComponent: Component {
    var radiansPerSecond: Float = .pi / 2
    var axis: SIMD3<Float> = normalize([1, 1, 1])
}

/// Per-frame update loop: rotates every entity that has a `SpinComponent`.
struct SpinSystem: System {
    private static let query = EntityQuery(where: .has(SpinComponent.self))

    init(scene: Scene) {}

    func update(context: SceneUpdateContext) {
        let deltaTime = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard let spin = entity.components[SpinComponent.self] else { continue }
            let rotation = simd_quatf(angle: spin.radiansPerSecond * deltaTime, axis: spin.axis)
            // Post-multiply so the rotation is about the entity's local axis.
            entity.orientation = entity.orientation * rotation
        }
    }
}
