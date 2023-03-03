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
    
    // MARK: - Colors
    
    private var backgroundColor: Color {
        colorScheme == .light ? Color(red:0.43, green:0.43, blue:0.43, opacity: 1) : Color(red:0.33, green:0.33, blue:0.33, opacity: 1)
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // Letters
                    ZStack {
                        Circle()
                            .fill(Color.primary.opacity(0.75))
                        VStack {
                            Image(systemName: "textformat")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                        }
                    }
                    .frame(width: 75, height: 75)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .onTapGesture {
                        setLetterMode()
                    }
                    
                    // Numbers
                    ZStack {
                        Circle()
                            .fill(Color.primary.opacity(0.75))
                        VStack {
                            Image(systemName: "number")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                        }
                    }
                    .frame(width: 75, height: 75)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .onTapGesture {
                        setNumberMode()
                    }
                    
                    // Symbols
                    ZStack {
                        Circle()
                            .fill(Color.primary.opacity(0.75))
                        VStack {
                            Image(systemName: "bolt")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                        }
                    }
                    .frame(width: 75, height: 75)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .onTapGesture {
                        setSymbolMode()
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(5)
            .actionSheet(isPresented: $showAlert) {
                ActionSheet(title: Text("Game Mode Changed"), message: Text("Your game mode has been changed to " + gameMode.capitalized + "."), buttons: [
//                    .destructive(Text("Restart"), action: {
//                        exit(EXIT_SUCCESS)
//                    }),
                    .cancel(Text("Restart Later"), action: {
                        // Close
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
