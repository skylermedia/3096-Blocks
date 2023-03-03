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
                    CircleButton(image: "tv", text: "Beep", action: {
                        setSoundBeep()
                        })
                    
                    // Can
                    CircleButton(image: "arrow.down", text: "Can", action: {
                        setSoundCan()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Click
                    CircleButton(image: "cursorarrow.click", text: "Click", action: {
                        setSoundClick()
                        })

                    // Hit
                    CircleButton(image: "arrow.rectanglepath", text: "Hit", action: {
                        setSoundHit()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Plant
                    CircleButton(image: "laurel.leading", text: "Plant", action: {
                        setSoundPlant()
                        })

                    // Toy
                    CircleButton(image: "airport.express", text: "Toy", action: {
                        setSoundToy()
                        })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Boing
                    CircleButton(image: "football", text: "Boing", action: {
                        setSoundBoing()
                        })

                    // Wood
                    CircleButton(image: "tornado", text: "Wood", action: {
                        setSoundWood()
                        })

                    Spacer()
                }
                HStack {
                    Spacer()
                    // Woosh
                    CircleButton(image: "wind", text: "Woosh", action: {
                        setSoundWoosh()
                        })
                    
                    // Default
                    CircleButton(image: "checkmark.seal", text: "Default", action: {
                        setSoundDefault()
                        })
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(5)
        .actionSheet(isPresented: $showAlert) {
            ActionSheet(title: Text("Sound Changed"), message: Text(""), buttons: [
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
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        // Haptics
        Haptic.light()
        self.showAlert = true
        print("Sound Changed")
    }
    
    func setSoundBeep() {
        audioSound = "beep"
        setSound()
    }
    
    func setSoundCan() {
        audioSound = "can"
        setSound()
    }
    
    func setSoundClick() {
        audioSound = "click"
        setSound()
    }
    
    func setSoundHit() {
        audioSound = "hit"
        setSound()
    }
    
    func setSoundPlant() {
        audioSound = "plant"
        setSound()
    }
    
    func setSoundToy() {
        audioSound = "toy"
        setSound()
    }
    
    func setSoundBoing() {
        audioSound = "boing"
        setSound()
    }
    
    func setSoundWood() {
        audioSound = "wood"
        setSound()
    }
    
    func setSoundWoosh() {
        audioSound = "woosh"
        setSound()
    }
    func setSoundDefault() {
        audioSound = "default"
        setSound()
    }
}

