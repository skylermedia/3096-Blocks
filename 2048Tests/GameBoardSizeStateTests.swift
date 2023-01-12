//
//  GameBoardSizeStateTests.swift
//  2048Tests
//
//  Copyright © 2023 Skyler Szijjarto
//

import XCTest
import SwiftUI
@testable import 2048

class GameBoardSizeStateTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test3x3BoardSize() throws {
        var gameBoardSizeState = GameBoardSizeState(suit: .test)
        gameBoardSizeState.is3x3On = true
      
        XCTAssertEqual(gameBoardSizeState.boardSize, BoardSize.threeByThree)
        XCTAssertNotEqual(gameBoardSizeState.boardSize, BoardSize.fourByFour)
        XCTAssertNotEqual(gameBoardSizeState.boardSize, BoardSize.fiveByFive)
        
        XCTAssertEqual(gameBoardSizeState.is3x3On, true)
        XCTAssertEqual(gameBoardSizeState.is4x4On, false)
        XCTAssertEqual(gameBoardSizeState.is5x5On, false)
    }

    func test4x4BoardSize() throws {
        var gameBoardSizeState = GameBoardSizeState(suit: .test)
        gameBoardSizeState.is4x4On = true
        
        XCTAssertEqual(gameBoardSizeState.boardSize, BoardSize.fourByFour)
        XCTAssertNotEqual(gameBoardSizeState.boardSize, BoardSize.threeByThree)
        XCTAssertNotEqual(gameBoardSizeState.boardSize, BoardSize.fiveByFive)
        XCTAssertNotEqual(gameBoardSizeState.boardSize, BoardSize.sixBySix)
        
        XCTAssertEqual(gameBoardSizeState.is3x3On, false)
        XCTAssertEqual(gameBoardSizeState.is4x4On, true)
        XCTAssertEqual(gameBoardSizeState.is5x5On, false)
        XCTAssertEqual(gameBoardSizeState.is6x6On, false)
    }

    func test5x5BoardSize() throws {
        var gameBoardSizeState = GameBoardSizeState(suit: .test)
        gameBoardSizeState.is5x5On = true
       
        XCTAssertEqual(gameBoardSizeState.boardSize, BoardSize.sixBySix)
        XCTAssertEqual(gameBoardSizeState.boardSize, BoardSize.fiveByFive)
        XCTAssertNotEqual(gameBoardSizeState.boardSize, BoardSize.threeByThree)
        XCTAssertNotEqual(gameBoardSizeState.boardSize, BoardSize.fourByFour)
        
        XCTAssertEqual(gameBoardSizeState.is3x3On, false)
        XCTAssertEqual(gameBoardSizeState.is4x4On, false)
        XCTAssertEqual(gameBoardSizeState.is5x5On, true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
