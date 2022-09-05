//
//  Flame.swift
//  Challenge-3-Matt-Pfeiffer
//
//  Created by Matt Pfeiffer on 9/5/22.
//

import SwiftUI

struct Flame: Shape {
    var wiggleFactorX: Double
    var wiggleFactorY: Double

    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(wiggleFactorX), Double(wiggleFactorY))
        }
        set {
            wiggleFactorX = newValue.first
            wiggleFactorY = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        // special animating top point (wiggles around)
        let wiggleAmountX = rect.maxX * wiggleFactorX * 0.1
        let wiggleAmountY = rect.maxX * wiggleFactorY * 0.1
        let topX = rect.midX + wiggleAmountX
        let topY = rect.minY + wiggleAmountY
        let top = CGPoint(x: topX, y: topY)

        // top control points
        let radiusForTop = rect.maxX * 0.05
        let topControl1Left = CGPoint(x: topX - radiusForTop, y: topY + radiusForTop)
        let topControl2Left = CGPoint(x: topX - radiusForTop, y: topY)
        let topControl1Right = CGPoint(x: topX + radiusForTop, y: topY + radiusForTop)
        let topControl2Right = CGPoint(x: topX + radiusForTop, y: topY)

        // other points
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let leftSemiCircle = CGPoint(x: rect.minX, y: rect.maxY * 0.6)
        let leftControl = CGPoint(x: rect.minX, y: rect.maxY)
        let rightSemiCircle = CGPoint(x: rect.maxX, y: rect.maxY * 0.6)
        let rightControl = CGPoint(x: rect.maxX, y: rect.maxY)

        // draw and return the path
        var path = Path()
        path.move(to: bottom)
        path.addQuadCurve(to: leftSemiCircle, control: leftControl)
        path.addCurve(to: top, control1: topControl1Left, control2: topControl2Left)
        path.addCurve(to: rightSemiCircle, control1: topControl2Right, control2: topControl1Right)
        path.addQuadCurve(to: bottom, control: rightControl)
        return path
    }
}
