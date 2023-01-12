//
//  SlideViewModifier.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct SlideViewModifier<T: Gesture>: ViewModifier {
    var gesture: T
    @Binding var presentEndGameModal: Bool
    @Binding var presentSideMenu: Bool
    
    func body(content: Content) -> some View {
        content
            .gesture(gesture, including: .all)
            .scaleEffect((presentEndGameModal || presentSideMenu) ? 0.9 : 1.0)
            .allowsHitTesting(!(presentEndGameModal || presentSideMenu))
    }
}
