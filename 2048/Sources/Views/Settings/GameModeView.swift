//
//  GameModeView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/23/23.
//

import SwiftUI

struct GameModeView: View {
    
    // MARK: - Environment
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    // MARK: - App Storage

    @AppStorage("gameMode") var gameMode = "symbols"
    
    // MARK: - Properties

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

struct GameModeView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeView()
    }
}
