//
//  Challenge_3_Fire_AnimationApp.swift
//  Shared
//
//  Created by Primoz Cuvan on 03.09.22.
//

import SwiftUI

@main
struct Challenge_3_Fire_AnimationApp: App {
    var body: some Scene {
        WindowGroup {
            FireView()
                .background(FireAnimationColor.background.actualColor)
        }
    }
}
