//
//  AnchorEntity+Camera.swift
//  CameraControls
//
//  Created by Tibor Felföldy on 2024-07-20.
//

import RealityKit

public extension AnchorEntity {
    enum CameraControlType {
        case orbit
    }
    
    static func camera(_ type: CameraControlType) -> AnchorEntity {
        switch type {
        case .orbit:
            let cameraAnchor = AnchorEntity()
            cameraAnchor.name = "CameraAnchor"
            cameraAnchor.components.set(OrbitCameraComponent())
            
            let camera = Entity()
            camera.name = "Camera"
            camera.components.set(PerspectiveCameraComponent())
            camera.transform.translation = [0, 0, 5]
            cameraAnchor.addChild(camera)
            return cameraAnchor
        }
    }
}
