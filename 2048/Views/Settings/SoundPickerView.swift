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
                    CircleButton(sfImage: false, image: "beep", text: "Beep", action: {
                        setSoundBeep()
                    })
                    
                    // Can
                    CircleButton(sfImage: false, image: "can", text: "Can", action: {
                        setSoundCan()
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Click
                    CircleButton(sfImage: false, image: "click", text: "Click", action: {
                        setSoundClick()
                    })
                    
                    // Hit
                    CircleButton(sfImage: false, image: "hit", text: "Hit", action: {
                        setSoundHit()
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Plant
                    CircleButton(sfImage: false, image: "plant", text: "Plant", action: {
                        setSoundPlant()
                    })
                    
                    // Toy
                    CircleButton(sfImage: false, image: "toy", text: "Toy", action: {
                        setSoundToy()
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Boing
                    CircleButton(sfImage: false, image: "boing", text: "Boing", action: {
                        setSoundBoing()
                    })
                    
                    // Wood
                    CircleButton(sfImage: false, image: "wood", text: "Wood", action: {
                        setSoundWood()
                    })
                    
                    Spacer()
                }
                HStack {
                    Spacer()
                    // Woosh
                    CircleButton(sfImage: true, image: "wind", text: "Woosh", action: {
                        setSoundWoosh()
                    })
                    
                    // Default
                    CircleButton(sfImage: true, image: "checkmark.seal", text: "Default", action: {
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
