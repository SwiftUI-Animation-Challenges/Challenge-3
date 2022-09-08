//
//  FuseView.swift
//  Fire Animation
//
//  Created by Mert Tecimen on 6.09.2022.
//

import SwiftUI

struct FuseView: View {
    @State private var scaleFactor1: CGSize = .init(width: 1, height: 1)
    @State private var scaleFactor2: CGSize = .init(width: 0.5, height: 0.5)
    @State private var rotationDegree: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                Circle()
                    .foregroundColor(.orange)
                    .scaleEffect(scaleFactor2)
                    .offset(y: -geometry.size.width * 1.7)
                Circle()
                    .foregroundColor(.orange)
                    .scaleEffect(scaleFactor1)
                    .offset(y: -geometry.size.width * 1)
                ZStack{
                    Circle()
                        .foregroundColor(.orange)
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: geometry.size.width * 4/6)
                }
                    
            }

            .frame(width: geometry.size.width)
            .onAppear{
                withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: false).delay(0)){
                    self.scaleFactor1 = .init(width: 0.1, height: 0.1)
                }
                withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: false).delay(0.1)){
                        self.scaleFactor2 = .init(width: 0.1, height: 0.1)
                }
            }
        }
        
    }
    
}

struct FuseView_Previews: PreviewProvider {
    static var previews: some View {
        FuseView()
    }
}
