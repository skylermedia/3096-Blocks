//
//  SkinSelectorView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/19/23.
//

import SwiftUI

struct SkinSelectorView: View {
    
    @State public var defaultSkinSelected = true
    @State public var gradientSkinSelected = false
    @State private var selection = GameBoardSizeState()

    var invertedBackgroundColor: Color
    var previewSize: CGSize
    
    var body: some View {
        VStack {
            boardSizeSettingView(skinName: "Default", isSelected: $selection.is6x6On)
                .onTapGesture {
                    defaultSkinSelected = true
                    UserDefaults.standard.set(self.defaultSkinSelected, forKey: "defaultSkinSelected")
                    Haptic.light()
                }
            boardSizeSettingView(skinName: "Gradient", isSelected: $selection.is5x5On)
                .onTapGesture {
                    gradientSkinSelected = true
                    Haptic.light()
                }
        }
    }
    
    private func boardSizeSettingView(skinName: String, isSelected: Binding<Bool>) -> some View {
        // Prevent the toggle to be turned off in cases when all the other selection states are false
        if !selection.is6x6On && !selection.is5x5On {
            DispatchQueue.main.async {
                isSelected.wrappedValue = true
            }
        }
        
        return Toggle(isOn: isSelected) {
            Text(skinName)
                .bold()
                .font(.headline)
        }
        .toggleStyle(CheckboxToggleStyle())
        .foregroundColor(Color.primary.opacity(0.5))
        .opacity(isSelected.wrappedValue ? 1.0 : 0.5)
        .shadow(
            color: invertedBackgroundColor.opacity(0.5),
            radius: isSelected.wrappedValue ? 10 : 0
        )
        .animation(.modalSpring, value: isSelected.wrappedValue)
        .padding([.top, .bottom])
    }
}
