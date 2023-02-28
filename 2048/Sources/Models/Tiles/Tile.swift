//
//  Tile.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation
import SwiftUI

typealias IndexPair = (Int, Int)

protocol Tile: Identifiable, Equatable {
    
    associatedtype Value
    
    var value: Value { get set }
}

struct IdentifiedTile: Tile {
    var id: Int
    var value: Int
    var specialType: SpecialTileType?
}

//struct IdentifiedTile: Tile, Identifiable, Equatable, Hashable {
//    var id: Int
//    var value: Int
//    var specialType: SpecialTileType?
//
//    init(value: Int, specialType: SpecialTileType? = nil) {
//        self.id =
//        self.value = value
//        self.specialType = specialType
//    }
//}

enum SpecialTileType {
    case bomb
    case lock
    // add any other special tile types here
}

struct IndexedTile<T: Tile> {
    
    typealias Index = IndexPair
    
    let index: Index
    let tile: T
}
