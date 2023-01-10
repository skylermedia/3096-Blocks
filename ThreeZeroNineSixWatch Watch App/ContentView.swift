//
//  ContentView.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Created by Skyler Szijjarto on 1/9/23.
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
