//
//  AudioSettingView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct AudioSettingView: View {
    
    // MARK: - AppStorage Properties
    
    @AppStorage(AppStorageKeys.audio.rawValue) var isAudioEnabled: Bool = true
    @State private var selectedSound = "default"
    
    // MARK: - Private Propeties
    
    private var invertedBackgroundColor: Color
    private var previewSize: CGSize

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
        }
    }
}
