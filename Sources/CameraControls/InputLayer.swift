//
//  InputLayer.swift
//  CameraControls
//
//  Created by Tibor Felföldy on 2024-07-20.
//

import SwiftUI

struct InputLayerModifier: ViewModifier {
    @GestureState private var dragAmount = CGSize.zero
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .updating($dragAmount) { value, state, _ in
                        state = value.translation
                        PanGestureSystem.panState = [Float(state.width),
                                                     Float(state.height)]
                    }
            )
    }
}

public extension View {
    func inputLayer() -> some View {
        modifier(InputLayerModifier())
    }
}
