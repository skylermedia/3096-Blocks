//
//  TimedView.swift
//  Weather Merge
//
//  Created by Skyler Szijjarto on 1/19/23.
//

import SwiftUI
import Combine
import CloudKit
import AVFoundation

//struct TimedView: View {
//
//    // MARK: - Proeprties
//
//    @State private var leaderboardData = [LeaderboardData]()
//    let userName = UserDefaults.standard.string(forKey: "userName")
//    let isAuthenticated = UserDefaults.standard.string(forKey: "isAuthenticated")
//
//    @ObservedObject private var logic: GameLogic
//
//    @State private var resetWithScore: Bool = UserDefaults.standard.bool(forKey: "audioSound")
//
//    @State private var selectedSound: String = UserDefaults.standard.string(forKey: "audioSound") ?? "default"
//    @State private var audioSound = UserDefaults.standard.string(forKey: "audioSound")
//
////    @EnvironmentObject var adsViewModel: AdsViewModel
//
//    @AppStorage(AppStorageKeys.audio.rawValue) var isAudioEnabled: Bool = true
//    @AppStorage(AppStorageKeys.haptic.rawValue) var isHapticEnabled: Bool = true
//
//    // MARK: - Initializers
//
//    init(board: GameLogic) {
//        self.logic = board
//    }
//
//    // MARK: - Comformance to View Protocol
//
//    let initialTiles = [[Tile(value: 2), Tile(value: 2), Tile(value: 0), Tile(value: 0)],
//                        [Tile(value: 0), Tile(value: 0), Tile(value: 0), Tile(value: 0)],
//                        [Tile(value: 0), Tile(value: 0), Tile(value: 0), Tile(value: 0)],
//                        [Tile(value: 0), Tile(value: 0), Tile(value: 0), Tile(value: 0)]]
//    let initialGameBoard = GameBoard(tiles: initialTiles)
//
//    var body: some Scene {
//        WindowGroup {
//            TimedGameView(gameBoard: initialGameBoard)
//        }
//    }
//
////    var body: some View {
////        VStack {
////            Spacer()
////            Text("Test")
////
////            Spacer()
////        }
////    }
//
//    // MARK: - Private Functions
//
//    private func resetGame() {
//        logic.reset()
//        adsViewModel.showInterstitial = true
//    }
//
//    private func playSound() {
//        if isAudioEnabled {
//            if selectedSound == "default" {
//                AudioSource.play(from: .ding)
//            } else if selectedSound == "sound1" {
////                AudioSource.play(from: .new)
//            }
//        }
//    }
//}

//struct TimedGameBoard {
//    var tiles: [[any Tile]] // a 2D array of Tile structs representing the game board
//    // add other properties and methods as needed
//}
//
//struct TimedTile {
//    var value: Int // the value of the tile (could be a letter in your game)
//    // add other properties and methods as needed
//}

struct TimedGameView: View {
    
    var body: some View {
        VStack {
            Text("Timed View")
        }
    }
}
