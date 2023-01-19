//
//  AudioSettingView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct AudioSettingView: View {
    
    // MARK: - AppStorage Properties
    
    @AppStorage(AppStorageKeys.audio.rawValue) var isAudioEnabled: Bool = true
    @AppStorage(AppStorageKeys.audioSound.rawValue) var selectedAudioSound: String = "default"
    @State private var selectedSound = "default"
    @State private var showSoundPicker = false
    
    // MARK: - Private Propeties
    
    private var invertedBackgroundColor: Color
    private var previewSize: CGSize
    private var audioSounds = ["default", "sound1", "sound2", "sound3", "sound4", "sound5"]

    // MARK: - Internal State Enum
    
    enum StateRepresentation: String {
        case enabled = "speaker.wave.3"
        case disabled = "speaker.slash"
    }
    
    // MARK: - Initializers
    
    init(invertedBackground: Color, previewSize: CGSize) {
        self.invertedBackgroundColor = invertedBackground
        self.previewSize = previewSize
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        audioSettingView()
    }
    
    // MARK: - Private Methods
    
    private func audioSettingView() -> some View {
        let systemImageName = isAudioEnabled ? StateRepresentation.enabled.rawValue : StateRepresentation.disabled.rawValue
        
        Haptic.light()
        
        return VStack(spacing: 20) {
            Toggle(isOn: $isAudioEnabled) {
                Image(systemName: systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: previewSize.height / 3)
                    .id(systemImageName)
                    .transition(
                        .asymmetric(
                            insertion: AnyTransition
                                .opacity
                                .combined(with: .scale(scale: 1.0))
                                .animation(.modalSpring),
                            removal:
                                AnyTransition
                                .opacity
                                .combined(with: .scale(scale: 0.0))
                                .animation(.modalSpring)
                        )
                    )
            }
            .toggleStyle(CheckboxToggleStyle())
            .foregroundColor(Color.primary.opacity(0.5))
            .shadow(color: invertedBackgroundColor.opacity(0.5), radius: 10)
            .animation(.modalSpring, value: isAudioEnabled)
            .padding([.leading, .leading, .top, .bottom])

//            HStack {
//                Text("Selected Sound: \(selectedSound)")
//                    .font(.system(.caption, design: .monospaced))
//                    .foregroundColor(Color.primary.opacity(0.5))
//                    .fontWeight(.bold)
//                Spacer()
//                Button(action: {
//                    self.showSoundPicker.toggle()
//                }) {
//                    Image(systemName: "chevron.down.circle")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 25, height: 25)
//                }
//            }
//            .padding()
//            .sheet(isPresented: $showSoundPicker) {
//                SoundPickerView(selectedSound: self.$selectedSound, audioSounds: self.audioSounds, onDismiss: {
//                    self.showSoundPicker = false
//                    self.selectedAudioSound = self.selectedSound
//                })
//            }
        }
    }
}

struct SoundPickerView: View {
    @Binding var selectedSound: String
    var audioSounds: [String]
    var onDismiss: () -> ()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select Sound", selection: $selectedSound) {
                        ForEach(audioSounds, id: \.self) { sound in
                            Text(sound)
                        }
                    }
                }
            }
            .navigationBarTitle("Sound Settings")
            .navigationBarItems(trailing: Button("Done", action: onDismiss))
        }
    }
}
