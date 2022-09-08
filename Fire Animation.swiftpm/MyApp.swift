import SwiftUI

@main
struct MyApp: App {
    @State var isStarted: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView(isStarted: $isStarted)
                .background(.black)
                .onTapGesture {
                    if !isStarted{
                        isStarted.toggle()
                    }
                }
        }
    }
}
