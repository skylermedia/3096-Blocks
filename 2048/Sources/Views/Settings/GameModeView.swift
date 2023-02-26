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

    @State private var gameMode = "letter"
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
                    
                    // Weather
                    ZStack {
                            Circle()
                                .fill(Color.primary.opacity(0.75))
                            VStack {
                                Image(systemName: "cloud")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                            }
                        }
                        .frame(width: 75, height: 75)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .onTapGesture {
                            setWeatherMode()
                        }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(5)
            .actionSheet(isPresented: $showAlert) {
                ActionSheet(title: Text("Restart"), message: Text("You may need to restart 3096 – Blocks to change this setting."), buttons: [
                    .destructive(Text("Restart"), action: {
                        exit(EXIT_SUCCESS)
                    }),
                    .cancel(Text("Restart Later"), action: {
                        // Close
                    }),
                ])
            }
        }
    }
    
        // MARK: - Functions

    func setLetterMode() {
            gameMode = "letter"
            // User Defaults
            UserDefaults.standard.set(gameMode, forKey: "gameMode")
            // Logging
        print(UserDefaults.standard.string(forKey: "gameMode") ?? "letter")
            // Haptics
            Haptic.light()
            self.showAlert = true
        }

    func setNumberMode() {
            gameMode = "number"
            // User Defaults
            UserDefaults.standard.set(gameMode, forKey: "gameMode")
            // Logging
        print(UserDefaults.standard.string(forKey: "gameMode") ?? "number")
            // Haptics
            Haptic.light()
            self.showAlert = true
    }
    
    func setWeatherMode() {
        gameMode = "weather"
        // User Defaults
        UserDefaults.standard.set(gameMode, forKey: "gameMode")
        // Logging
        print(UserDefaults.standard.string(forKey: "gameMode") ?? "weather")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
}
