//
//  ThreeZeroNineSixWatchApp.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Created by Skyler Szijjarto on 1/9/23.
//

import SwiftUI

@main
struct AppleWatchGame_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(GameLogic())
        }
    }
}
