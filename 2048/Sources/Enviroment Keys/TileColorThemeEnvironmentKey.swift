//
//  TileColorThemeEnvironmentKey.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct TileColorThemeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: TileColorTheme = StandardTileColorTheme()
//    public static let gradientValue: TileColorTheme = GradientTileColorScheme()
}

extension EnvironmentValues {
    var tileColorTheme: TileColorTheme {
        set { self[TileColorThemeEnvironmentKey.self] = newValue }
        get { self[TileColorThemeEnvironmentKey.self] }
    }
}
