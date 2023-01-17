//
//  SelectedView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum SelectedView {
    case game
    case settings
    case leaderboard
    case about
    
    var title: String {
        switch self {
        case .game:
            return "3096"
        case .settings:
            return "Settings"
        case .leaderboard:
            return "Leaderboard"
        case .about:
            return "About"

        }
    }
}
