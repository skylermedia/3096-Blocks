//
//  TileColorTheme.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

protocol TileColorTheme {
    typealias TilePair = (background: Color, font: Color)
    
    var defaultLightTileColors: [TilePair] { get }
    var defaultDarkTileColors: [TilePair] { get }
    
    
    func colorPair(for index: Int?, _ colorScheme: ColorScheme, defaultColor: Color) -> TilePair
}

extension TileColorTheme {
    func colorPair(for index: Int?, _ colorScheme: ColorScheme, defaultColor: Color) -> TilePair {
            guard let number = index else {
                return (defaultColor, Color.black)
            }
            guard defaultLightTileColors.count == defaultDarkTileColors.count else {
                fatalError("The palettes for the light and dark color schemes do not match.")
            }
            
            let index = Int(log2(Double(number))) - 1
            
            if index < 0 || index >= defaultLightTileColors.count {
                fatalError("This number has no associated color.")
            }
            return colorScheme == .light ? defaultLightTileColors[index] : defaultDarkTileColors[index]
    }
}
