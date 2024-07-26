//
//  CameraControlSystem.swift
//  CameraControls
//
//  Created by Tibor Felföldy on 2024-07-20.
//

import RealityKit

@MainActor
public struct CameraControlSystem: @preconcurrency System {
    public static let dependencies: [SystemDependency] = [
        .after(PanGestureSystem.self)
    ]
    
    let query = EntityQuery(where: .has(OrbitCameraComponent.self))
    
    public init(scene: Scene) {}
    
    public func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: query,
                                       updatingSystemWhen: .rendering) {
            let component = entity.components[OrbitCameraComponent.self]
            guard let component else { continue }
            
            rotate(entity: entity, value: [
                PanGestureSystem.value.x * component.rotationSpeed,
                PanGestureSystem.value.y * component.rotationSpeed
            ])
        }
    }
    
    private func rotate(entity: Entity, value: SIMD2<Float>) {
        guard value != .zero else { return }
        
        let yaw: simd_quatf = {
            var angle = entity.transform.eulerAngles.yaw
            angle += value.x
            return simd_quatf(angle: angle, axis: [0, 1, 0])
        }()

        let pitch: simd_quatf = {
            var angle = entity.transform.eulerAngles.pitch
            angle += value.y
            angle = min(.pi / 1.99, angle)
            angle = max(.pi / -1.99, angle)
            return simd_quatf(angle: angle, axis: [1, 0, 0])
        }()
        
        entity.transform.rotation = simd_mul(yaw, pitch)
    }
}

struct EulerAngles {
    let matrix: float4x4
    
    var yaw: Float {
        atan2(matrix.columns.2.x, matrix.columns.2.z)
    }
    
    var pitch: Float {
        let sinPitch = -matrix.columns.2.y
        if sinPitch >= 1.0 {
            return Float.pi / 2.0
        } else if sinPitch <= -1.0 {
            return -Float.pi / 2.0
        } else {
            return asin(sinPitch)
        }
    }
    
    var roll: Float {
        atan2(matrix.columns.1.y, matrix.columns.1.x)
    }
}

extension Transform {
    var eulerAngles: EulerAngles {
        EulerAngles(matrix: matrix)
    }
}
