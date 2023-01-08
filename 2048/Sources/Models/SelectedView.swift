//
//  SelectedView.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum SelectedView {
    case game
    case settings
    case about
    
    var title: String {
        switch self {
        case .game:
            return "3096"
        case .settings:
            return "Settings"
        case .about:
            return "About"
        }
    }
}
