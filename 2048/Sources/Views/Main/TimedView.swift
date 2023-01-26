//
//  TimedView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/19/23.
//

import SwiftUI
import Combine
import CloudKit
import AVFoundation

struct TimedView: View {
    
    // MARK: - Proeprties
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var adsViewModel: AdsViewModel
    
    @State private var ignoreGesture = false
    @State private var presentEndGameModal = false
    @State private var hasGameEnded = false
    @State private var viewState = CGSize.zero
    
    @State private var sideMenuViewState = CGSize.zero
    @State private var presentSideMenu = false
    
    @State private var timeRemaining: Double = 60.0
    
    @ObservedObject private var logic: GameLogic
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.colorSchemeBackgroundTheme) private var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme
    
    @State private var selectedView: SelectedView = .game
    @State private var score: Int = 0
    @State private var highScore: Int = 0
    @State private var scoreMultiplier: Int = 0
    
    @State private var totalScore: Int = 1
    @State private var totalSwipes: Int = 0
    @State private var totalGames: Int = 0
    @State private var averageScore: Int = 0
    @State private var averageSwipes: Int = 0
    
    @State private var leaderboardData = [LeaderboardData]()
    let userName = UserDefaults.standard.string(forKey: "userName")
    let isAuthenticated = UserDefaults.standard.string(forKey: "isAuthenticated")
    
    @State private var selectedSound: String = UserDefaults.standard.string(forKey: "audioSound") ?? "default"
    
    @AppStorage(AppStorageKeys.audio.rawValue) var isAudioEnabled: Bool = true
    @AppStorage(AppStorageKeys.haptic.rawValue) var isHapticEnabled: Bool = true
    
    // MARK: - Initializers
    
    init(board: GameLogic) {
        self.logic = board
        highScore = UserDefaults.standard.integer(forKey: "highScore")
        selectedSound = UserDefaults.standard.string(forKey: "audioSound") ?? "default"
    }
    
    // MARK: - Comformance to View Protocol
    
    var body: some View {
        NavigationView {
            if (isAuthenticated != nil) == false {
                LoginView(boardSize: 4)
            } else {
                VStack {
                    GameStateBottomView(
                        hasGameEnded: $hasGameEnded,
                        presentEndGameModal: $presentEndGameModal,
                        sideMenuViewState: $sideMenuViewState,
                        score: $score,
                        resetGame: resetGame
                    )
                }
            }
        }
    }
    
    // MARK: - Methods
    
    private func headerView(_ proxy: GeometryProxy) -> some View {
        HeaderView(
            proxy: proxy,
            showSideMenu: $presentSideMenu,
            title: selectedView.title,
            score: $score,
            scoreMultiplier: $scoreMultiplier,
            newGameAction: {
                presentEndGameModal = true
            },
            showResetButton: {
                selectedView == .game
            }
        )
    }
    // MARK: - Private Functions
    
    private func resetGame() {
        logic.reset()
        adsViewModel.showInterstitial = true
    }
}
