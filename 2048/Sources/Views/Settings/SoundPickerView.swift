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
                    CircleButton(image: Image(systemName: "tv"), text: Text("Beep"), action: {
                        setSoundBeep()
                        })
                    
                    // Can
                    CircleButton(image: Image(systemName: "arrow.down"), text: Text("Can"), action: {
                        setSoundCan()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Click
                    CircleButton(image: Image(systemName: "cursorarrow.click"), text: Text("Click"), action: {
                        setSoundClick()
                        })

                    // Hit
                    CircleButton(image: Image(systemName: "arrow.rectanglepath"), text: Text("Hit"), action: {
                        setSoundHit()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Plant
                    CircleButton(image: Image(systemName: "laurel.leading"), text: Text("Plant"), action: {
                        setSoundPlant()
                        })

                    // Toy
                    CircleButton(image: Image(systemName: "airport.express"), text: Text("Toy"), action: {
                        setSoundToy()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Boing
                    CircleButton(image: Image(systemName: "football"), text: Text("Boing"), action: {
                        setSoundBoing()
                        })

                    // Wood
                    CircleButton(image: Image(systemName: "tornado"), text: Text("Wood"), action: {
                        setSoundWood()
                        })

                    Spacer()
                }
                HStack {
                    Spacer()
                    // Woosh
                    CircleButton(image: Image(systemName: "wind"), text: Text("Woosh"), action: {
                        setSoundWoosh()
                        })
                    
                    // Default
                    CircleButton(image: Image(systemName: "checkmark.seal"), text: Text("Default"), action: {
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
    
    func setSound() {
        Haptic.light()
        self.showAlert = true
    }
    
    func setSoundBeep() {
        audioSound = "beep"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    
    func setSoundCan() {
        audioSound = "can"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    
    func setSoundClick() {
        audioSound = "click"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    
    func setSoundHit() {
        audioSound = "hit"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    
    func setSoundPlant() {
        audioSound = "plant"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    
    func setSoundToy() {
        audioSound = "toy"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    
    func setSoundBoing() {
        audioSound = "boing"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    
    func setSoundWood() {
        audioSound = "wood"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    
    func setSoundWoosh() {
        audioSound = "woosh"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
    func setSoundDefault() {
        audioSound = "default"
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // All Sounds
        setSound()
    }
}

