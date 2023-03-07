//
//  SoundPickerView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/22/23.
//

import SwiftUI

struct SoundPickerView: View {
    
    // MARK: - Properties
    
    @AppStorage("gameSound") var gameSound = "default"
    
    // Alert
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
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
                    CircleButton(image: "cursorarrow.click.2", text: "Click", action: {
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
                    CircleButton(image: "leaf", text: "Wood", action: {
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
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
    
    // MARK: - Functions
    
    func setSound() {
        // User Defaults
        UserDefaults.standard.set(gameSound, forKey: "gameSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "gameSound") ?? "Audio Sound")
        print("Sound changed to \(gameSound)")
        // Haptics
        Haptic.light()
        // Alert
        showAlert(title: "Your game sound has been changed to " + gameSound.capitalized + ".")
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    func setSoundBeep() {
        gameSound = "beep"
        setSound()
    }
    
    func setSoundCan() {
        gameSound = "can"
        setSound()
    }
    
    func setSoundClick() {
        gameSound = "click"
        setSound()
    }
    
    func setSoundHit() {
        gameSound = "hit"
        setSound()
    }
    
    func setSoundPlant() {
        gameSound = "plant"
        setSound()
    }
    
    func setSoundToy() {
        gameSound = "toy"
        setSound()
    }
    
    func setSoundBoing() {
        gameSound = "boing"
        setSound()
    }
    
    func setSoundWood() {
        gameSound = "wood"
        setSound()
    }
    
    func setSoundWoosh() {
        gameSound = "woosh"
        setSound()
    }
    
    func setSoundDefault() {
        gameSound = "default"
        setSound()
    }
}
