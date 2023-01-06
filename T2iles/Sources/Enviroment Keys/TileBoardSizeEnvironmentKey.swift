//
//  TileBoardSizeEnvironmentKey.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct TileBoardSizeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: Int = 4
}

extension EnvironmentValues {
    var tileBoardSize: Int {
        set { self[TileBoardSizeEnvironmentKey.self] = newValue }
        get { self[TileBoardSizeEnvironmentKey.self] }
    }
}
