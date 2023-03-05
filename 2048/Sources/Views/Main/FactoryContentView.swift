//
//  FactoryContentView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct FactoryContentView<G: Gesture>: View {

    // MARK: - Properties
    
    @Binding var selectedView: SelectedView
    
    var gesture: G
    
    @ObservedObject var gameLogic: GameLogic
    
    @Binding var presentEndGameModal: Bool
    @Binding var presentSideMenu: Bool

    // MARK: - Conformacne to View Protocol
    
    @ViewBuilder var body: some View {
        currentView()
            .modifier(SlideViewModifier(gesture: gesture,
                                        presentEndGameModal: $presentEndGameModal,
                                        presentSideMenu: $presentSideMenu))
    }

    // MARK: - Private Properties
    
    private var tileBoardView: some View {
        TileBoardView(matrix: gameLogic.tiles,
                      tileEdge: gameLogic.lastGestureDirection.invertedEdge,
                      tileBoardSize: gameLogic.boardSize)
            .padding(.bottom, 24)
    }
    
    private var levelView: some View {
        LevelView()
            .padding(.bottom, 24)
    }
    
    private var settingsView: some View {
        SettingsView()
            .padding(.top, -64)
    }
    
    private var ranksView: some View {
        LeaderboardView()
            .padding(.top, -64)
            .padding(.bottom, 24)
    }
    
    private var timedView: some View {
        TimedGameView()
            .padding(.top, -64)
            .padding(.bottom, 24)
    }
    
    private var statsView: some View {
        StatsView()
            .padding(.top, -64)
            .padding(.bottom, 24)
    }
    
    private var aboutView: some View {
        AboutView()
            .padding(.top, -64)
            .padding(.bottom, 24)
    }
    
    private var multiplayerView: some View {
        AboutView()
            .padding(.top, -64)
            .padding(.bottom, 24)
    }
    
    private var loginView: some View {
        BetaLoginView()
            .padding(.top, -64)
            .padding(.bottom, 24)
    }
    
    // MARK: - Private Methods
    
    @ViewBuilder
    private func currentView() -> some View {
        switch selectedView {
        case .game:
            tileBoardView
        case .levels:
            levelView
        case .ranks:
            ranksView
        case .timed:
            timedView
        case .login:
            loginView
        case .stats:
            statsView
        case .multiplayer:
            multiplayerView
        case .settings:
            settingsView
        case .about:
            aboutView
        }
    }
}
