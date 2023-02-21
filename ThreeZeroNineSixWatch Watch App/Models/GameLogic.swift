//
//  GameLogic.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation
import SwiftUI
import Combine

final class GameLogic : ObservableObject {
    
    enum Direction: Codable {
        case left
        case right
        case up
        case down
    }
    
    enum SpecialTileType {
        case bomb
        case x2
    }

    fileprivate var currentSpecialTile: SpecialTileType?

    func activateSpecialTile(_ tileType: SpecialTileType) {
        currentSpecialTile = tileType
    }

    func deactivateSpecialTile() {
        currentSpecialTile = nil
    }

    func isSpecialTile(_ block: Block) -> Bool {
        if let tileType = currentSpecialTile {
            switch tileType {
            case .bomb:
                return block.special == .bomb
            case .x2:
                return block.special == .x2
            }
        }
        return false
    }

    func mergeSpecialTile(_ block1: Block, _ block2: Block) -> Block {
        if let tileType = currentSpecialTile {
            switch tileType {
            case .bomb:
                let mergedBlock = Block(id: newGlobalID, number: 0, special: nil)
                for row in (block1.row-1)...(block1.row+1) {
                    for col in (block1.col-1)...(block1.col+1) {
                        if let block = _blockMatrix[BlockMatrixType.Index(row: row, col: col)] {
                            if isSpecialTile(block) {
                                // If the block is a special tile, activate its power and remove it
                                switch block.special! {
                                case .bomb:
                                    // When a bomb tile is cleared, all blocks around the tile will be destroyed
                                    for row2 in (row-1)...(row+1) {
                                        for col2 in (col-1)...(col+1) {
                                            if let block2 = _blockMatrix[BlockMatrixType.Index(row: row2, col: col2)] {
                                                _blockMatrix.remove(block2)
                                                sum += block2.number
                                            }
                                        }
                                    }
                                case .x2:
                                    // When an x2 tile is cleared, the value of the resulting block will be doubled
                                    block.number *= 2
                                    _blockMatrix.place(block, to: BlockMatrixType.Index(row: row, col: col))
                                // Add other cases for other special tile types
                                }
                            } else {
                                // If the block is not a special tile, just remove it
                                _blockMatrix.remove(block)
                                sum += block.number
                            }
                        }
                    }
                }
                
                generateNewBlocks()
                
                if moved {
                    saveGame()
                }
            } // <-- Add this line
        } // <-- Add this line
        
        // The rest of the method follows here...
    }

    
    enum Power {
        case clearRow
        case clearColumn
        case clearBlock
        case shuffle
        // add other powers here
    }

    typealias BlockMatrixType = BlockMatrix<IdentifiedBlock>
    
    let objectWillChange = PassthroughSubject<GameLogic, Never>()
    
    fileprivate var _blockMatrix: BlockMatrixType!
    var blockMatrix: BlockMatrixType {
        return _blockMatrix
    }
    
    @Published var sum = 0
    
    @Published fileprivate(set) var lastGestureDirection: Direction = .up
    
    struct SavedGame: Codable {
        var blockMatrix: BlockMatrixType
        var sum: Int
        var lastGestureDirection: Direction
    }
    
    fileprivate var savedGame: SavedGame? {
        didSet {
            saveGame()
        }
    }
    
    fileprivate var _globalID = 0
    fileprivate var newGlobalID: Int {
        _globalID += 1
        return _globalID
    }
    
    init() {
        resumeGame()
    }
    
    func newGame() {
        sum = 0
        _blockMatrix = BlockMatrixType()
        resetLastGestureDirection()
        generateNewBlocks()
        
        objectWillChange.send(self)
    }
    
    func resumeGame() {
        if let game = loadGame() {
            _blockMatrix = game.blockMatrix
            lastGestureDirection = game.lastGestureDirection
            sum = game.sum
            generateNewBlocks()
            
            objectWillChange.send(self)
        } else {
            newGame()
        }
    }
    
    func resetLastGestureDirection() {
        lastGestureDirection = .up
    }
    
    func move(_ direction: Direction) {
        defer {
            objectWillChange.send(self)
        }
        
        lastGestureDirection = direction
        
        var moved = false
        
        let axis = direction == .left || direction == .right
        for row in 0..<4 {
            var rowSnapshot = [IdentifiedBlock?]()
            var compactRow = [IdentifiedBlock]()
            for col in 0..<4 {
                // Transpose if necessary.
                if let block = _blockMatrix[axis ? (col, row) : (row, col)] {
                    rowSnapshot.append(block)
                    compactRow.append(block)
                }
                rowSnapshot.append(nil)
            }
            
            merge(blocks: &compactRow, reverse: direction == .down || direction == .right)
            
            var newRow = [IdentifiedBlock?]()
            compactRow.forEach { newRow.append($0) }
            if compactRow.count < 4 {
                for _ in 0..<(4 - compactRow.count) {
                    if direction == .left || direction == .up {
                        newRow.append(nil)
                    } else {
                        newRow.insert(nil, at: 0)
                    }
                }
            }
            
            newRow.enumerated().forEach {
                if rowSnapshot[$0]?.number != $1?.number {
                    moved = true
                }
                _blockMatrix.place($1, to: axis ? ($0, row) : (row, $0))
            }
        }
        
        if moved {
            generateNewBlocks()
        }
        savedGame = SavedGame(blockMatrix: _blockMatrix, sum: sum, lastGestureDirection: lastGestureDirection)
    }
    
    fileprivate func merge(blocks: inout [IdentifiedBlock], reverse: Bool) {
        if reverse {
            blocks = blocks.reversed()
        }
        if isSpecialTile(blocks[0].block) || isSpecialTile(blocks[1].block) {
            // handle special tile merging here
            let specialBlock = mergeSpecialTile(blocks[0].block, blocks[1].block)
            blocks = [IdentifiedBlock(id: blocks[0].id, block: specialBlock)]
        } else if blocks[0].block.number == blocks[1].block.number {
            // handle regular block merging here
            blocks = blocks
                .map { (false, $0) }
                .reduce([(Bool, IdentifiedBlock)]()) { acc, item in
                    if acc.last?.0 == false && acc.last?.1.block.number == item.1.block.number {
                        var accPrefix = Array(acc.dropLast())
                        var mergedBlock = item.1.block
                        mergedBlock.number *= 2
                        accPrefix.append((true, IdentifiedBlock(id: item.1.id, block: mergedBlock)))
                        return accPrefix
                    } else {
                        var accTmp = acc
                        accTmp.append((false, item.1))
                        return accTmp
                    }
                }
                .map { $0.1 }
            
            if reverse {
                blocks = blocks.reversed()
            }
        }
    }

    func isSpecialTile(_ block: Block) -> Bool {
        // logic to check if block is a special tile
        return false
    }

    func mergeSpecialTile(_ block1: Block, _ block2: Block) -> Block {
        // logic to merge special tiles
        return block1
    }
    
    @discardableResult fileprivate func func generateNewBlocks() {
        // Count the number of blocks currently in the matrix
        let blockCount = _blockMatrix.count
        
        // Generate new blocks as before
        let blocks = generateBlocks(count: 4 - blockCount)
        for block in blocks {
            _blockMatrix.place(block)
        }
        
        // If the number of blocks in the matrix is a multiple of 10, generate a special tile
        if blockCount % 10 == 0 {
            let specialTileTypes: [SpecialTileType] = [.bomb, .x2] // Add other special tile types here
            let randomIndex = Int.random(in: 0..<specialTileTypes.count)
            let specialTileType = specialTileTypes[randomIndex]
            let block = Block(id: newGlobalID, number: 0, special: specialTileType)
            _blockMatrix.place(block)
        }
    }
        
        func isSpecialTile(_ block: IdentifiedBlock) -> Bool {
            // return true if the block is a special tile
        }

        func activatePower(forSpecialTiles specialTiles: [SpecialTile]) {
            let specialTileType = specialTiles.first!.type
            let power = specialTiles.first!.power
            switch power {
            case .clearRow:
                // clear the row that the special tiles are in
                for i in 0..<gameGrid.width {
                            gameGrid.removeTileAt(x: i, y: selectedTile!.y)
                        }
                        score += 100
                break
            case .clearColumn:
                // clear the column that the special tiles are in
            case .clearBlock:
                // clear all tiles adjacent to the special tiles
            case .shuffle:
                // shuffle the positions of all tiles on the board
            // add other power implementations here
            }
        }

        guard blankLocations.count >= 2 else {
            return false
        }
        
        // Do not forget to sync data.
        defer {
            objectWillChange.send(self)
        }
        
        // Place the first block.
        var placeLocIndex = Int.random(in: 0..<blankLocations.count)
        _blockMatrix.place(IdentifiedBlock(id: newGlobalID, number: 2), to: blankLocations[placeLocIndex])
        
        sum += 2
        
//        // Place the second block
//        guard let lastLoc = blankLocations.last else {
//            return false
//        }
//        blankLocations[placeLocIndex] = lastLoc
//        placeLocIndex = Int.random(in: 0..<(blankLocations.count - 1))
//        _blockMatrix.place(IdentifiedBlock(id: newGlobalID, number: 2), to: blankLocations[placeLocIndex])
//
//        sum += 2
//
        return true
    }
    
//    fileprivate func forEachBlockIndices(mode: ForEachMode = .rowByRow,
//                                         reversed: Bool = false,
//                                         _ action: (BlockMatrixType.Index) -> ()) {
//        var indices = (0..<4).map { $0 }
//        if reversed {
//            indices = indices.reversed()
//        }
//
//        for row in indices {
//            for col in indices {
//                if mode == .rowByRow {
//                    action((col, row))
//                } else {
//                    action((row, col))  // transpose
//                }
//            }
//        }
//    }
    
    func saveGame() {
        if let encoded = try? JSONEncoder().encode(savedGame) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "Game")
        }
    }

    func loadGame() -> SavedGame? {
        let defaults = UserDefaults.standard
        if let saved = defaults.object(forKey: "Game") as? Data {
            let decoder = JSONDecoder()
            if let loaded = try? decoder.decode(SavedGame.self, from: saved) {
                return loaded
            }
        }
        return nil
    }
    
}
