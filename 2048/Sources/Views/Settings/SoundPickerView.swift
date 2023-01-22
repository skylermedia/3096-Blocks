//
//  SoundPickerView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/22/23.
//

import SwiftUI

struct SoundPickerView: View {
    
    // MARK: - Variables
        
    @State private var audioSound = "Default"
    @State private var showAlert = false
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        HStack {
            Spacer()
            
            // Default Sound
            Button("Default") {
                setDefaultSound()
            }
            .buttonStyle(.bordered)
            .foregroundColor(Color.primary.opacity(0.5))
            
            Spacer()
            
            // Woosh
            Button("Woosh") {
                setWooshSound()
            }
            .buttonStyle(.bordered)
            .foregroundColor(Color.primary.opacity(0.5))
            
            // Sound 2
//            Button("Sound2") {
//                setSound2()
//            }
//            .buttonStyle(.bordered)
//            .foregroundColor(.black)
            
            Spacer()
        }
        .padding(5)
        .actionSheet(isPresented: $showAlert) {
            ActionSheet(title: Text("Requires Restart"), message: Text("You must restart 3096 – Blocks to change this setting."), buttons: [
                .destructive(Text("Restart"), action: {
                    exit(EXIT_SUCCESS)
                }),
                .cancel(Text("Restart Later"), action: {
                    // Close
                }),
            ])
        }
    }

    // MARK: - Functions
    
    func setDefaultSound() {
        audioSound = "default"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        self.showAlert = true
    }

    func setWooshSound() {
        audioSound = "woosh"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        // Restart App
        self.showAlert = true
    }

    func setSound2() {
        audioSound = "sound2"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        // Restart App
        self.showAlert = true
    }
}

