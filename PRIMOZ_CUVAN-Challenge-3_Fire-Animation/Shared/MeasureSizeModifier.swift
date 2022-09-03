//
//  MeasureSizeModifier.swift
//  Challenge-3_Fire-Animation
//
//  Created by Primoz Cuvan on 03.09.22.
//

import SwiftUI

struct MeasureSizeModifier: ViewModifier {
    
    @Binding var size: CGSize
    
    public func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { reader in
                    Color.clear.onAppear {
                        size = reader.size
                    }
                }
            }
    }
}

extension View {
    func measureSize(_ size: Binding<CGSize>) -> some View {
        self.modifier(MeasureSizeModifier(size: size))
    }
}
