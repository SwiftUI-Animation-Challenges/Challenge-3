//
//  FusePathView.swift
//  Fire Animation
//
//  Created by Mert Tecimen on 7.09.2022.
//

import SwiftUI

struct FusePathView: View {
    
    let width: CGFloat
    let height: CGFloat
    let fuseSegments: [CGPoint]
    let strokeColor: Color
    
    init(width: CGFloat, height: CGFloat, fuseSegments: [CGPoint], strokeColor: Color = .black) {
        self.width = width
        self.height = height
        self.fuseSegments = fuseSegments
        self.strokeColor = strokeColor
    }
    
    var body: some View {
        Path { path in
            // Top middle start point.
            path.move(
                to: CGPoint(
                    x: width * 0.5,
                    y: height * 0.0
                )
            )
            
            fuseSegments.forEach { segment in
                path.addLine(
                    to: CGPoint(
                        x: width * segment.x,
                        y: height * segment.y
                    )
                )
            }
        }
        .stroke(strokeColor)
    }
}

