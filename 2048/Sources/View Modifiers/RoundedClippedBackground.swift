//
//  RoundedClippedBackground.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct RoundedClippedBackground: ViewModifier {
    let backgroundColor: Color
    let proxy: GeometryProxy

    func body(content: Content) -> some View {
        content
            .background(Rectangle().fill(backgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.primary.opacity(0.3), radius: 20)
    }
}

