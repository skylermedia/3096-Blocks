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
    
    // Alert
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    CircleButton(sfImage: true, image: "textformat", text: "Letters", action: setLetterMode)
                    CircleButton(sfImage: true, image: "number", text: "Numbers", action: setNumberMode)
                    CircleButton(sfImage: true, image: "bolt", text: "Symbols", action: setSymbolMode)
                    Spacer()
                }
                Spacer()
            }
            .padding(5)
//            .actionSheet(isPresented: $showAlert) {
//                ActionSheet(title: Text("Game Mode Changed"), message: Text("Your game mode has been changed to " + gameMode.capitalized + "."), buttons: [
//                    .cancel(Text("Confirm"), action: {
//                    }),
//                ])
//            }
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    } 
    
    // MARK: - Functions
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    func changeGameMode() {
        Haptic.light()
        showAlert(title: "Your game mode has been changed to " + gameMode.capitalized + ".") 
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
