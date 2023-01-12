//
//  FilledBackgroundStyle.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct FilledBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .background(Color.primary)
            .cornerRadius(25)
            .animation(.modalSpring, value: configuration.isPressed)
    }
}
