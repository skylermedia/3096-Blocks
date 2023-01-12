//
//  HapticControler.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/11/23.
//

import SwiftUI

class Haptics {
    static let instance = Haptics()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
