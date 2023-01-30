//
//  BlurEffect.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct BlurEffect: ViewModifier {
    
    let blurRaduis: CGFloat
    
    func body(content: Self.Content) -> some View {
        content.blur(radius: blurRaduis)
    }
    
}

