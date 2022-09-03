//
//  FireShape.swift
//  Challenge-3_Fire-Animation
//
//  Created by Primoz Cuvan on 03.09.22.
//

import SwiftUI

struct FireShape: Shape {
    
    let width: CGFloat
    var spikePositionX: CGFloat
    var spikePositionY: CGFloat
    var fireSpikeRadius: CGFloat
    
    var animatableData: AnimatablePair<CGFloat,CGFloat> {
        get { AnimatablePair(spikePositionX, spikePositionY) }
        set {
            spikePositionX = newValue.first
            spikePositionY = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let offset: CGFloat = rect.height/15
        
        let firstPoint = CGPoint(
            x: rect.midX,
            y: rect.midY + offset
        )

        let secondPoint = CGPoint(
            x: rect.midX + spikePositionX,
            y: rect.midY - spikePositionY + offset
        )

        let thirdPoint = CGPoint(
            x: rect.midX + width/2,
            y: rect.midY + offset
        )
        
        path.addArc(center: firstPoint, radius: width/2,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)

        path.addCurve(to: CGPoint(x: secondPoint.x, y: secondPoint.y),
                      control1: CGPoint(x: secondPoint.x - fireSpikeRadius,
                                        y: secondPoint.y),
                      control2: CGPoint(x: secondPoint.x - fireSpikeRadius,
                                        y: secondPoint.y))

        path.addCurve(to: CGPoint(x: thirdPoint.x, y: thirdPoint.y),
                      control1: CGPoint(x: secondPoint.x + fireSpikeRadius,
                                        y: secondPoint.y),
                      control2: CGPoint(x: secondPoint.x + fireSpikeRadius,
                                        y: secondPoint.y))
        

        return path
    }
}
