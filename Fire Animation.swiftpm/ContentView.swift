import SwiftUI

struct ContentView: View {
    
    @Binding var isStarted: Bool
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        GeometryReader { geometry in
            Text("Tap to Start")
                .foregroundColor(viewModel.textColor)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .onAppear{
                    withAnimation(.easeIn(duration: 1).repeatForever(autoreverses: true)){
                        viewModel.textColor = .orange
                    }
                }
                .opacity(!isStarted ? 1 : 0)
            ZStack(alignment: .topLeading) {
                // Uncommnet to see randomly generated fuse path:
                //FusePathView(width: geometry.size.width, height: geometry.size.height, fuseSegments: viewModel.fuseSegments, strokeColor: .white)
                ZStack{
                    Circle()
                        .fill(viewModel.radialGradient)
                    FuseView()
                        .rotationEffect(Angle(degrees: viewModel.rotationDegree))
                        .frame(width: 25, height: 25)
                        
                }
                .opacity((viewModel.isFuseVisible && isStarted) ? 1 : 0)
                .position(x: geometry.size.width * viewModel.xOffset, y: geometry.size.height * viewModel.yOffset)
                .frame(width: 100, height: 100)
                if !viewModel.isFuseVisible{
                    ZStack{
                        Circle()
                            .fill(viewModel.largeRadialGradient)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        FireView()
                            .transition(.scale)
                            .frame(width: geometry.size.width / 1.1, height: geometry.size.height / 1.5)
                            
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height/1.5)
                }
                
                    
            }
            .onChange(of: isStarted){ _ in
                viewModel.animate(size: geometry.size)
            }
        }
    }
}
