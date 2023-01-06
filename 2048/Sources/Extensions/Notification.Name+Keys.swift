//
//  Notification.Name+Keys.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

extension Notification.Name {
    static var gameBoardSize = Notification.Name("eleev.astemir.2048-swiftui-game.board.size")
    static var gameBoardSizeUserInfoKey = "game.board.size"
    
    static var audio = Notification.Name("eleev.astemir.2048-swiftui-audio")
    static var audioUserInfoKey = "audio"

}
