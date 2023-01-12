//
//  ThreeZeroNineSixWatchApp.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Copyright © 2023 Skyler Szijjarto
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
