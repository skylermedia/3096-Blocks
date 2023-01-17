//
//  StandardTileColorTheme.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation
import struct SwiftUI.Color

struct StandardTileColorTheme: TileColorTheme {
    var lightTileColors: [TilePair] = [
        (Color(red:0.91, green:0.87, blue:0.83, opacity:1.00), Color(red:0.42, green:0.39, blue:0.35, opacity: 1.00)), // 3
        (Color(red:0.90, green:0.86, blue:0.76, opacity:1.00), Color(red:0.42, green:0.39, blue:0.35, opacity: 1.00)), // 6
        (Color(red:0.93, green:0.67, blue:0.46, opacity:1.00), Color.white), // 12
        (Color(red:0.94, green:0.57, blue:0.38, opacity:1.00), Color.white), // 24
        (Color(red:0.95, green:0.46, blue:0.33, opacity:1.00), Color.white), // 48
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 96
        (Color(red:0.91, green:0.78, blue:0.43, opacity:1.00), Color.white), // 192
        (Color(red:0.91, green:0.78, blue:0.37, opacity:1.00), Color.white), // 384
        (Color(red:0.90, green:0.77, blue:0.31, opacity:1.00), Color.white), // 768
        (Color(red:0.91, green:0.75, blue:0.24, opacity:1.00), Color.white), // 1,536
        (Color(red:0.91, green:0.74, blue:0.18, opacity:1.00), Color.white), // 3,072
        (Color(red:0.91, green:0.72, blue:0.12, opacity:1.00), Color.white), // 6,144
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 12,288
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 24,576
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 49,152
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 98,304
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 196,608
    ]
    
    var darkTileColors: [TilePair] = [
        (Color(red:0.81, green:0.77, blue:0.73, opacity:1.00), Color(red:0.32, green:0.29, blue:0.25, opacity: 1.00)), // 3
        (Color(red:0.80, green:0.76, blue:0.66, opacity:1.00), Color(red:0.32, green:0.29, blue:0.5, opacity: 1.00)), // 6
        (Color(red:0.83, green:0.57, blue:0.36, opacity:1.00), Color.white), // 12
        (Color(red:0.84, green:0.47, blue:0.28, opacity:1.00), Color.white), // 24
        (Color(red:0.85, green:0.36, blue:0.23, opacity:1.00), Color.white), // 48
        (Color(red:0.84, green:0.25, blue:0.13, opacity:1.00), Color.white), // 96
        (Color(red:0.81, green:0.68, blue:0.33, opacity:1.00), Color.white), // 192
        (Color(red:0.81, green:0.68, blue:0.27, opacity:1.00), Color.white), // 384
        (Color(red:0.80, green:0.67, blue:0.21, opacity:1.00), Color.white), // 768
        (Color(red:0.81, green:0.65, blue:0.14, opacity:1.00), Color.white), // 1,536
        (Color(red:0.81, green:0.64, blue:0.08, opacity:1.00), Color.white), // 3,072
        (Color(red:0.81, green:0.62, blue:0.02, opacity:1.00), Color.white), // 6,144
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 12,288
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 24,576
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 49,152
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 98,304
        (Color(red:0.94, green:0.35, blue:0.23, opacity:1.00), Color.white), // 196,608
    ]
}
