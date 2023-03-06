//
//  SoundPickerView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/22/23.
//

import SwiftUI

struct SoundPickerView: View {
    
    // MARK: - Properties
    
    @State private var audioSound = "Default"

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
//        .actionSheet(isPresented: $showAlert) {
//            ActionSheet(title: Text("Sound Changed"), message: Text("Your game sound has been changed to " + audioSound.capitalized + "."), buttons: [
//                .destructive(Text("Restart"), action: {
//                    exit(EXIT_SUCCESS)
//                }),
//                .cancel(Text("Restart Later"), action: {
//                    // Close
//                }),
//            ])
//        }
    }

    // MARK: - Functions
    
    func setSound() {
        // User Defaults
        UserDefaults.standard.set(audioSound, forKey: "audioSound")
        // Logging
        print(UserDefaults.standard.string(forKey: "audioSound") ?? "Audio Sound")
        print("Sound changed to \(audioSound)")
        // Haptics
        Haptic.light()
        // Alert
        showAlert(title: "Your game sound has been changed to " + audioSound.capitalized + ".")
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
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

