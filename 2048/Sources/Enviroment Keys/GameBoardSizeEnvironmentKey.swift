//
//  GameBoardSizeEnvironmentKey.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct GameBoardSizeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: BoardSize = .fourByFour
}

extension EnvironmentValues {
    var gameBoardSize: BoardSize {
        set { self[GameBoardSizeEnvironmentKey.self] = newValue }
        get { self[GameBoardSizeEnvironmentKey.self] }
    }
}
