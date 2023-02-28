//
//  ColorSchemeBackgroundThemeEnvironmentKey.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct ColorSchemeBackgroundThemeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: ColorSchemeBackgroundTheme = StandardBackgroundColorScheme()
}

extension EnvironmentValues {
    var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme {
        set { self[ColorSchemeBackgroundThemeEnvironmentKey.self] = newValue }
        get { self[ColorSchemeBackgroundThemeEnvironmentKey.self] }
    }
}
