//
//  TileColorThemeEnvironmentKey.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct TileColorThemeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: TileColorTheme = StandardTileColorTheme()
}

extension EnvironmentValues {
    var tileColorTheme: TileColorTheme {
        set { self[TileColorThemeEnvironmentKey.self] = newValue }
        get { self[TileColorThemeEnvironmentKey.self] }
    }
}
