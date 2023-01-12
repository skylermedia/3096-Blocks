//
//  Notification.Name+Keys.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

extension Notification.Name {
    static var gameBoardSize = Notification.Name("com.szijjarto.3096Game.board.size")
    static var gameBoardSizeUserInfoKey = "game.board.size"
    
    static var audio = Notification.Name("com.szijjarto.3096Game.-swiftui-audio")
    static var audioUserInfoKey = "audio"

    static var haptic = Notification.Name("com.szijjarto.3096Game.-swiftui-haptic")
    static var hapticUserInfoKey = "haptic"
}
