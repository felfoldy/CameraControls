//
//  CameraControlSystem.swift
//  CameraControls
//
//  Created by Tibor Felföldy on 2024-07-20.
//

import RealityKit

@MainActor
struct CameraControlSystem: @preconcurrency System {
    static let dependencies: [SystemDependency] = [.after(PanGestureSystem.self)]
    
    init(scene: Scene) {}
    
    func update(context: SceneUpdateContext) {
        
    }
}
