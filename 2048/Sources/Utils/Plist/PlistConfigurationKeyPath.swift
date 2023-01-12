//
//  PlistConfigurationKeyPath.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum PlistConfigurationKeyPath: String {
    
    // MARK: - About
    
    case about
    case copyright
    case linkDescription
    case linkUrl
    
    // MARK: - Settings
    
    case settings
    case gameBoardDescription
    case gameBoardSize
    case audio
    case audioDescription
    case haptic
    case hapticDescription
    
    // MARK: - Game Board State
    
    case gameState
    case gameOverTitle
    case gameOverSubtitle
    case resetGameTitle
    case resetGameSubtitle
}
