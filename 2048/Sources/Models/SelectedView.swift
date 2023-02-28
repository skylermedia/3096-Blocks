//
//  SelectedView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum SelectedView {
    case game
//    case timed
    case multiplayer
    case ranks
    case stats
    case settings
    case about
    
    var title: String {
        switch self {
        case .game:
            return "Game"
//        case .timed:
//            return "Timed"
        case .multiplayer:
            return "Multiplayer"
        case .ranks:
            return "Ranks"
        case .stats:
            return "Stats"
        case .settings:
            return "Settings"
        case .about:
            return "About"

        }
    }
}
