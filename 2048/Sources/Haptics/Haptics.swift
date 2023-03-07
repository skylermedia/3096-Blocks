//
//  Haptics.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

class Haptic {
    
    static func heavy() {
        Haptics.instance.impact(style: .heavy)
    }
    
    static func light() {
        Haptics.instance.impact(style: .light)
    }
    
    static func medium() {
        Haptics.instance.impact(style: .medium)
    }
    
    static func rigid() {
        Haptics.instance.impact(style: .rigid)
    }
    
    static func soft() {
        Haptics.instance.impact(style: .soft)
    }
    
}
