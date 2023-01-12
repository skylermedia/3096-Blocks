//
//  HapticSettingsView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/11/23.
//

import SwiftUI

struct HapticSettingsView: View {
    
    // MARK: - AppStorage Properties
    
    @AppStorage(AppStorageKeys.haptic.rawValue) var isHapticEnabled: Bool = true
    
    // MARK: - Private Propeties
    
    private var invertedBackgroundColor: Color
    private var previewSize: CGSize
    
    // MARK: - Internal State Enum
    
    enum StateRepresentation: String {
        case enabled = "iphone.homebutton.radiowaves.left.and.right"
        case disabled = "iphone.homebutton.slash"
    }
    
    // MARK: - Initializers
    
    init(invertedBackground: Color, previewSize: CGSize) {
        self.invertedBackgroundColor = invertedBackground
        self.previewSize = previewSize
    }
    
    // MARK: - Conformance to View protocol
    
    var body: some View {
        hapticSettingsView()
    }
    
    // MARK: - Private Methods
    
    private func hapticSettingsView() -> some View {
        let systemImageName = isHapticEnabled ? StateRepresentation.enabled.rawValue : StateRepresentation.disabled.rawValue
        
        Haptic.light()
        
        return Toggle(isOn: $isHapticEnabled) {
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
        .animation(.modalSpring, value: isHapticEnabled)
        .padding([.leading, .leading, .top, .bottom])
    }
}
