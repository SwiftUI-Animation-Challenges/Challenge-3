//
//  FireView.swift
//  Challenge-3_Fire-Animation
//
//  Created by Primoz Cuvan on 03.09.22.
//

import SwiftUI

struct FireView: View {
    
    @State var showMiniFire: Bool = false
    @State var fireShapeRotation: Angle = Angle()
    @State var measuredViewSize: CGSize = CGSize()
    
    let fireShapeRotationTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var frame: CGSize?
    var fireSizeConstant: CGFloat {
        if let frame = frame {
            return frame.width > frame.height ? frame.height/2 : frame.width/2
        } else {
            return measuredViewSize.width > measuredViewSize.height ? measuredViewSize.height/2 : measuredViewSize.width/2
        }
    }
    
    internal init(frame: CGSize? = nil) {
        self.frame = frame
    }

    var body: some View {
        if let frame = frame {
            fire.frame(width: frame.width, height: frame.height)
        } else {
            fire.measureSize($measuredViewSize)
        }
    }
    
    private var fire: some View {
        ZStack {            
            firstFireLayer
            miniFire
            secondFireLayer
            thirdFireLayer
        }
    }
    
    private var firstFireLayer: some View {
        FireAnimationView(viewSize: frame ?? measuredViewSize,
                          fireColor: .tertiary,
                          fireDynamicConstant: 0.1,
                          fireWidth: fireSizeConstant,
                          fireHeight: fireSizeConstant/1.8,
                          fireOffsetX: -fireSizeConstant/3.5)
    }
    
    private var miniFire: some View {
        FireShape(width: fireSizeConstant/8,
                  spikePositionX: 0,
                  spikePositionY: fireSizeConstant/8,
                  fireSpikeRadius: fireSizeConstant/40)
            .fill(FireAnimationColor.secondary.actualColor)
            .rotationEffect(fireShapeRotation)
            .offset(x: -fireSizeConstant/6, y: showMiniFire ? -fireSizeConstant/1.1 : fireSizeConstant/5)
            .opacity(showMiniFire ? 0.1 : 1)
            .foregroundColor(.red)
            .animation(.easeIn(duration: 0.5).repeatForever(autoreverses: false), value: showMiniFire)
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showMiniFire.toggle()
                }
            }
            .onReceive(fireShapeRotationTimer) { _ in
                fireShapeRotation = Angle(degrees: Double(Int.random(in: -2...2)*5))
            }
    }
    
    private var secondFireLayer: some View {
        FireAnimationView(viewSize: frame ?? measuredViewSize,
                          fireColor: .secondary,
                          fireDynamicConstant: 0.15,
                          fireWidth: fireSizeConstant,
                          fireHeight: fireSizeConstant/1.5)
    }
    
    private var thirdFireLayer: some View {
        FireAnimationView(viewSize: frame ?? measuredViewSize,
                          fireColor: .primary,
                          fireDynamicConstant: 0.15,
                          fireWidth: fireSizeConstant/2,
                          fireHeight: fireSizeConstant/4)
    }
}

struct FireView_Previews: PreviewProvider {
    static var previews: some View {
        FireView()
    }
}
