//
//  Edge+InvertedDirection.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

extension Edge {
    
    var inverted: Edge {
        switch self {
        case .top:
            return .bottom
        case .bottom:
            return .top
        case .leading:
            return .trailing
        case .trailing:
            return .leading
        }
    }
}
