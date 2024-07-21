//
//  InputLayer.swift
//  CameraControls
//
//  Created by Tibor Felföldy on 2024-07-20.
//

import SwiftUI

struct InputLayerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        PanGestureSystem.panState = .changed(value.translation)
                    }
                    .onEnded { value in
                        PanGestureSystem.panState = .ended(value.translation)
                    }
            )
    }
}

public extension View {
    func inputLayer() -> some View {
        modifier(InputLayerModifier())
    }
}
