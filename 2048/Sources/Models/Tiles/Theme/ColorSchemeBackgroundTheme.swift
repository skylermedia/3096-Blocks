//
//  ColorSchemeBackgroundTheme.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

protocol ColorSchemeBackgroundTheme {
    
    // MARK: - Properties
    
    var light: Color { get }
    var dark: Color { get }
    
    // MARK: - Methods
    
    func backgroundColor(for colorScheme: ColorScheme) -> Color
    func invertedBackgroundColor(for colorScheme: ColorScheme) -> Color
}

extension ColorSchemeBackgroundTheme {
    func backgroundColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? light : dark
    }
    
    func invertedBackgroundColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? light : dark
    }
}

struct StandardBackgroundColorScheme: ColorSchemeBackgroundTheme {
    var light: Color = Color(red:0.90, green:0.90, blue:0.90, opacity:1.00)
    var dark: Color = Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
}
