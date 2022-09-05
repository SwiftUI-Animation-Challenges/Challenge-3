//
//  AnimationFlameView.swift
//  Challenge-3-Matt-Pfeiffer
//
//  Created by Matt Pfeiffer on 9/5/22.
//

import SwiftUI

struct AnimationFlameView: View {
    @State private var wiggleFactor1 = CGSize(width: -1.0, height: -1.0)
    @State private var wiggleFactor2 = CGSize(width: -1.0, height: -1.0)
    
    let lightBlue = Color(red: 170/255, green: 211/255, blue: 253/255)
    let yellow = Color(red: 255/255, green: 196/255, blue: 47/255)
    let orange = Color(red: 254/255, green: 136/255, blue: 36/255)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Flame(wiggleFactorX: wiggleFactor1.width, wiggleFactorY: wiggleFactor1.height)
                    .fill(.orange)
                Flame(wiggleFactorX: wiggleFactor2.width, wiggleFactorY: wiggleFactor2.height)
                    .fill(yellow)
                    .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                    .offset(y: geo.size.height * 0.03) // magic number
            }
            .padding(.horizontal, 50)
            .aspectRatio(1.0, contentMode: .fit)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(lightBlue)
        }
        .onAppear {
            stepInnerFlame()
            stepOuterFlame()
        }
    }

    func stepOuterFlame() {
        withAnimation {
            wiggleFactor2 = CGSize(width: CGFloat.random(in: -1...1), height: CGFloat.random(in: -1...1))
        }
        
        let delayValue = CGFloat.random(in: 0.0...0.25)
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(delayValue)) {
            self.stepOuterFlame()
        }
    }
    
    func stepInnerFlame() {
        withAnimation {
            wiggleFactor1 = CGSize(width: CGFloat.random(in: -1...1), height: CGFloat.random(in: -1...1))
        }
        
        let delayValue = CGFloat.random(in: 0.0...0.25)
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(delayValue)) {
            self.stepInnerFlame()
        }
    }
}

struct AnimationFlameView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationFlameView()
    }
}
