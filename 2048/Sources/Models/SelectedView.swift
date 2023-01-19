//
//  SelectedView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum SelectedView {
    case game
    case ranks
    case settings
    case about
    
    var title: String {
        switch self {
        case .game:
            return "3096"
        case .ranks:
            return "Ranks"
        case .settings:
            return "Settings"
        case .about:
            return "About"

        }
    }
}
