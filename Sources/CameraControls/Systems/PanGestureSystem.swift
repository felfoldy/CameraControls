//
//  PanGestureSystem.swift
//  CameraControls
//
//  Created by Tibor Felföldy on 2024-07-20.
//

import RealityKit
import Foundation

@MainActor
public class PanGestureSystem: System {
    enum State {
        case changed(CGSize)
        case ended(CGSize)
        case inactive
        
        var offset: CGSize {
            switch self {
            case let .changed(offset): offset
            case let .ended(offset): offset
            case .inactive: .zero
            }
        }
    }
    
    public static var value: SIMD2<Float> = .zero
    
    static var panState = State.inactive
    private var lastState = State.inactive
    
    required public init(scene: Scene) {}
    
    public func update(context: SceneUpdateContext) {
        let offset = PanGestureSystem.panState.offset
        
        if offset != .zero {
            let lastOffset = lastState.offset
            
            PanGestureSystem.value = [
                Float(lastOffset.width - offset.width),
                Float(lastOffset.height - offset.height)
            ]
            
            if case .ended = PanGestureSystem.panState {
                PanGestureSystem.panState = .inactive
            }
            
            lastState = PanGestureSystem.panState
        } else {
            PanGestureSystem.value = .zero
        }
    }
}
