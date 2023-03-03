//
//  GameModeView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/23/23.
//

import SwiftUI

struct GameModeView: View {
    
    // MARK: - Properties
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var gameMode = "symbols"
    @State private var showAlert = false
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    CircleButton(image: "textformat", text: "Letters", action: setLetterMode)
                    CircleButton(image: "number", text: "Numbers", action: setNumberMode)
                    CircleButton(image: "bolt", text: "Symbols", action: setSymbolMode)
                    Spacer()
                }
                Spacer()
            }
            .padding(5)
            .actionSheet(isPresented: $showAlert) {
                ActionSheet(title: Text("Game Mode Changed"), message: Text("Your game mode has been changed to " + gameMode.capitalized + "."), buttons: [
                    .cancel(Text("Confirm"), action: {
                    }),
                ])
            }
        }
    } 
    
    // MARK: - Functions
    
    func changeGameMode() {
        UserDefaults.standard.set(gameMode, forKey: "gameMode")
        Haptic.light()
        self.showAlert = true
    }
    
    func setLetterMode() {
        gameMode = "letters"
        changeGameMode()
    }
    
    func setNumberMode() {
        gameMode = "numbers"
        changeGameMode()
    }
    
    func setSymbolMode() {
        gameMode = "symbols"
        changeGameMode()
    }
}
