//
//  FireView.swift
//  Fire Animation
//
//  Created by Mert Tecimen on 7.09.2022.
//

import SwiftUI

struct FlameShape: Shape, Animatable{
    
    private var x: CGFloat = 0.5
    private var y: CGFloat = 0
    
    var animatableData: AnimatablePair<CGFloat, CGFloat>{
        get{ .init(x, y) }
        set{
            x = newValue.first
            y = newValue.second
        }
    }
    
    init(animatableData: AnimatablePair<CGFloat, CGFloat> = .init(0.5, 0) ) {
        self.animatableData = animatableData
    }
    
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: .init(
                x: rect.width * x,
                y: rect.height * y)
            )
            
            path.addCurve(
                to: .init(
                    x: rect.width * 1,
                    y: rect.height * 0.7
                ),
                control1: .init(
                    x: rect.width * 0.6,
                    y: rect.height * 0
                ),
                control2: .init(
                    x: rect.width * 0.9,
                    y: rect.height * 0.5
                )
            )
            
            path.addCurve(
                to: .init(
                    x: rect.width * 0.5,
                    y: rect.height * 1
                ),
                control1: .init(
                    x: rect.width * 1,
                    y: rect.height * 0.7
                ), control2: .init(
                    x: rect.width * 1,
                    y: rect.height * 1
                )
            )
            
            path.addCurve(
                to: .init(
                    x: rect.width * 0,
                    y: rect.height * 0.7
                ),
                control1: .init(
                    x: rect.width * 0,
                    y: rect.height * 1
                ), control2: .init(
                    x: rect.width * 0,
                    y: rect.height * 0.7
                )
            )
            
        
            
            path.addCurve(
                to: .init(
                    x: rect.width * x,
                    y: rect.height * y
                ),
                control1: .init(
                    x: rect.width * 0.1,
                    y: rect.height * 0.5
                ), control2: .init(
                    x: rect.width * 0.40,
                    y: rect.height * 0
                )
            )
            
        

            
        }
    }
    
}

struct FireView: View {
    @State private var flameMotion: AnimatablePair<CGFloat, CGFloat> = .init(0.5, 0)
    let timer = Timer.publish(every: 0.2, on: .main, in: .default).autoconnect()
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .topLeading){
                
                FlameShape(animatableData: .init(flameMotion.first * CGFloat.random(in: 0.5...1.5), flameMotion.second * CGFloat.random(in: -0.5...1)))
                    .fill(Color.orange)
                    .opacity(0.6)
                    .rotationEffect(Angle(degrees: -10), anchor: .init(x: 0, y: 0.7))
                    .offset(.init(width: 0, height: 0.35 * geometry.size.height))
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                
                FlameShape(animatableData: flameMotion)
                    .fill(Color.orange)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .onReceive(timer){ _ in
                        withAnimation(.linear(duration: 0.2)){
                            flameMotion = .init(CGFloat.random(in: 0.2...0.7), CGFloat.random(in: -0.2...0))
                        }
                    }
                    
                FlameShape(animatableData: flameMotion)
                    .fill(Color.yellow)
                    .offset(.init(width: geometry.size.width / 4, height: 0.35 * geometry.size.height))
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    
                
            }
        }
    }
}

struct FireView_Previews: PreviewProvider {
    static var previews: some View {
        FireView()
    }
}
