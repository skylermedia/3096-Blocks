//
//  SelectedView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum SelectedView {
    case game
    case timed
    case login
    case multiplayer
    case ranks
    case stats
    case profile
    case settings
    case levels
    case about
    
    var title: String {
        switch self {
        case .game:
            return "Game"
        case .levels:
            return "Levels"
        case .timed:
            return "Timed"
        case .stats:
            return "Stats"
        case .multiplayer:
            return "Multiplayer"
        case .login:
            return "Beta Login"
        case .ranks:
            return "Ranks"
        case .settings:
            return "Settings"
        case .profile:
            return "Profile"
        case .about:
            return "About"

        }
    }
}
