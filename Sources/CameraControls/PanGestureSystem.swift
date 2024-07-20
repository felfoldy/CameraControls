//
//  PanGestureSystem.swift
//  CameraControls
//
//  Created by Tibor Felföldy on 2024-07-20.
//

import RealityKit

@MainActor
public struct PanGestureSystem: System {
    public static var value: SIMD2<Float> = .zero
    
    static var panState: SIMD2<Float> = .zero
    private var lastState: SIMD2<Float> = .zero
    
    public init(scene: Scene) {}
    
    public func update(context: SceneUpdateContext) {
        PanGestureSystem.value = [
            Float(lastState.x - PanGestureSystem.panState.x),
            Float(lastState.y - PanGestureSystem.panState.y)
        ]
    }
}
