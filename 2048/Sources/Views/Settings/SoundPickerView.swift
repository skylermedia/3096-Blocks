//
//  SoundPickerView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/22/23.
//

import SwiftUI

struct SoundPickerView: View {
    
    // MARK: - Properties
        
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var audioSound = "Default"
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
                HStack {
                    Spacer()
                    // Beep
                    CircleButton(image: Image(systemName: "tv"), text: Text("Beep"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundBeep()
                        })
                    
                    // Can
                    CircleButton(image: Image(systemName: "arrow.down"), text: Text("Can"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundCan()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Click
                    CircleButton(image: Image(systemName: "cursorarrow.click"), text: Text("Click"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundClick()
                        })

                    // Hit
                    CircleButton(image: Image(systemName: "arrow.rectanglepath"), text: Text("Hit"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundHit()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Plant
                    CircleButton(image: Image(systemName: "laurel.leading"), text: Text("Plant"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundPlant()
                        })

                    // Toy
                    CircleButton(image: Image(systemName: "airport.express"), text: Text("Toy"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundToy()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Boing
                    CircleButton(image: Image(systemName: "football"), text: Text("Boing"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundBoing()
                        })

                    // Wood
                    CircleButton(image: Image(systemName: "tornado"), text: Text("Wood"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundWood()
                        })

                    Spacer()
                }
                HStack {
                    Spacer()
                    // Woosh
                    CircleButton(image: Image(systemName: "wind"), text: Text("Woosh"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundWoosh()
                        })
                    
                    // Default
                    CircleButton(image: Image(systemName: "checkmark.seal"), text: Text("Default"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
                        setSoundDefault()
                        })
                    Spacer()
                }
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
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundCan() {
        audioSound = "can"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundClick() {
        audioSound = "click"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundHit() {
        audioSound = "hit"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundPlant() {
        audioSound = "plant"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundToy() {
        audioSound = "toy"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundBoing() {
        audioSound = "boing"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundWood() {
        audioSound = "wood"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundWoosh() {
        audioSound = "woosh"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        // Restart App
        self.showAlert = true
    }
    func setSoundDefault() {
        audioSound = "default"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        // Restart App
        self.showAlert = true
    }
}

