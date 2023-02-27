//
//  Settings.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/29/23.
//

import Foundation
import SwiftUI

// MARK: - Title Style

struct SettingsTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.system(.title, design: .monospaced))
                .foregroundColor(.white)
                .fontWeight(.black)
        } else {
            content
                .font(.system(.title, design: .monospaced))
                .foregroundColor(Color.primary.opacity(0.5))
        }
    }
}

// MARK: - Description Style

struct SettingsDescriptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.white)
                .fontWeight(.bold)
        } else {
            content
                .font(.system(.body, design: .monospaced))
                .foregroundColor(Color.primary.opacity(0.5))
        }
    }
}
