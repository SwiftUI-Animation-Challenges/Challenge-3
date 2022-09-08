//
//  ContentView + ViewModel.swift
//  Fire Animation
//
//  Created by Mert Tecimen on 7.09.2022.
//

import Foundation
import SwiftUI

extension ContentView{
    class ViewModel: ObservableObject{
        var fuseSegments: [CGPoint]
        var radialGradient: RadialGradient
        var largeRadialGradient: RadialGradient
        @Published var xOffset: CGFloat
        @Published var yOffset: CGFloat
        @Published var rotationDegree: CGFloat
        @Published var isFuseVisible: Bool
        @Published var textColor: Color = .white
        var fuseDelay: Double
        
        init(fuseDelay: Double = 1.0){
            self.xOffset = 0.5
            self.yOffset = 0
            fuseSegments = []
            let duoGradient = Gradient(colors: [.yellow, .black])
            self.radialGradient = .radialGradient(duoGradient, center: .center, startRadius: 10, endRadius: 50)
            self.largeRadialGradient = .radialGradient(duoGradient, center: .center, startRadius: 0, endRadius: 300)
            self.rotationDegree = 0
            self.fuseDelay = fuseDelay
            self.isFuseVisible = true
            generateFuseSegments()
        }
        
        private func generateFuseSegments(){
            for index in 0..<Int.random(in: 10...20){
                fuseSegments.append(.init(
                    x: CGFloat.random(
                        in: (0.05 * CGFloat((index/100)))...0.95
                    ),
                    y: CGFloat.random(
                        in: 0.05...0.95)
                    )
                )
            }
            // Bottom mid end point
            fuseSegments.append(CGPoint(x: 0.5, y: 1.0))
        }
        
        func animate(index: Int = 0, size: CGSize){
            if fuseSegments.count == index{
                withAnimation(.easeOut(duration: 0.5)){
                    self.isFuseVisible = false
                }
                return
            }
            rotateFuseView(pointCoef: fuseSegments[index], size: size)
            withAnimation(.linear(duration: self.fuseDelay)){
                xOffset =  self.fuseSegments[index].x
                yOffset =  self.fuseSegments[index].y
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.fuseDelay){ [unowned self] in
                animate(index: index+1, size: size)
            }
        }
        
        func rotateFuseView(pointCoef: CGPoint, size: CGSize){
            let start = CGPoint(
                x: size.width * xOffset,
                y: size.height * yOffset
            )
            let end = CGPoint(
                x: size.width * pointCoef.x,
                y: size.height * pointCoef.y
            )
            let slope = atan2(start.y - end.y, start.x - end.x) * 180/Double.pi
            self.rotationDegree = 90 + slope
        }
        
    }
}
