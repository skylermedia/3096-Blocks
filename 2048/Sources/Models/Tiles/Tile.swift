//
//  Tile.swift
//  3096 – Blocks
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

struct TileNI: View {
    var image: String
    var number: String
    var color: Color
        
    var body: some View {
        ZStack {
            Image(systemName: image)
                .font(.monospaced(.title)())
                .foregroundColor(color)
                .font(.title)
            Text(number)
                .offset(x: 25, y: 25)
                .font(.body)
                .fontWeight(.black)
        }
    }
}
