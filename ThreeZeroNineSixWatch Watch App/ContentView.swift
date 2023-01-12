//
//  ContentView.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct ContentView: View {
    
    var gameLogic: GameLogic = GameLogic()
    
    var body: some View {
        VStack {
            Spacer()
            GameView()
                .environmentObject(gameLogic)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
