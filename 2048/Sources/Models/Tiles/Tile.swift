//
//  Tile.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

typealias IndexPair = (Int, Int)

protocol Tile: Identifiable, Equatable {
    
    associatedtype Value
    
    var value: Value { get set }
}

struct IdentifiedTile: Tile {
    var id: Int
    var value: Int
}

struct IndexedTile<T: Tile> {
    
    typealias Index = IndexPair
    
    let index: Index
    let tile: T
}

