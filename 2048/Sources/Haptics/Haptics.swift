//
//  HapticSource.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/11/23.
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
