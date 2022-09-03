//
//  FireAnimationView.swift
//  Challenge-3_Fire-Animation
//
//  Created by Primoz Cuvan on 03.09.22.
//

import SwiftUI

struct FireAnimationView: View {
    
    var viewSize: CGSize
    @State var spikePositionX: CGFloat = 0
    @State var spikePositionY: CGFloat = 0
    
    let fireColor: FireAnimationColor
    let fireDynamicConstant: CGFloat
    let fireWidth: CGFloat
    let fireHeight: CGFloat
    let fireOffsetX: CGFloat
    
    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    internal init(viewSize: CGSize,
                  fireColor: FireAnimationColor,
                  fireDynamicConstant: CGFloat,
                  fireWidth: CGFloat,
                  fireHeight: CGFloat,
                  fireOffsetX: CGFloat = 0) {
        
        self.viewSize = viewSize
        self.fireColor = fireColor
        self.fireDynamicConstant = fireDynamicConstant
        self.fireWidth = fireWidth
        self.fireHeight = fireHeight
        self.fireOffsetX = fireOffsetX
    }

    var body: some View {
        FireShape(width: fireWidth,
                  spikePositionX: spikePositionX,
                  spikePositionY: spikePositionY,
                  fireSpikeRadius: fireWidth * 0.03)
            .fill(fireColor.actualColor)
            .onReceive(timer) { _ in
                withAnimation(.spring()) {
                    updateView()
                }
            }
    }
    
    private func updateView() {
        let limitX = Int(fireWidth/2 * fireDynamicConstant)
        let randomX = Int.random(in: -limitX/2...limitX/2) * 2
        
        let limitY = Int(fireHeight * fireDynamicConstant)
        let randomY = Int.random(in: 0...limitY) * 2
        
        spikePositionX = fireOffsetX + CGFloat(randomX)
        spikePositionY = fireHeight + CGFloat(randomY)
    }
}
