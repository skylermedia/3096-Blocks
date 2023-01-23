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
            VStack {
                HStack {
                    Spacer()
                    // Beep
                    Button("Beep") {
                        setSoundBeep()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.primary.opacity(0.5))

                    // Can
                    Button("Can") {
                        setSoundCan()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.primary.opacity(0.5))
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Click
                    Button("Click") {
                        setSoundClick()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.primary.opacity(0.5))

                    // Hit
                    Button("Hit") {
                        setSoundHit()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.primary.opacity(0.5))
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Plant
                    Button("Plant") {
                        setSoundPlant()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.primary.opacity(0.5))

                    // Toy
                    Button("Toy") {
                        setSoundToy()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.primary.opacity(0.5))
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Boing
                    Button("Boing") {
                        setSoundBoing()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.primary.opacity(0.5))

                    // Woosh
                    Button("Woosh") {
                        setWooshSound()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.primary.opacity(0.5))

                    Spacer()
                }
                // Default
                Button("Default") {
                    setDefaultSound()
                }
                .buttonStyle(.bordered)
                .foregroundColor(Color.primary.opacity(0.5))
            }
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
    
    func setSoundBeep() {
        audioSound = "beep"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundCan() {
        audioSound = "can"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundClick() {
        audioSound = "click"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundHit() {
        audioSound = "hit"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundPlant() {
        audioSound = "plant"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundToy() {
        audioSound = "toy"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound"))
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundBoing() {
        audioSound = "boing"
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
    func setDefaultSound() {
        audioSound = "default"
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

