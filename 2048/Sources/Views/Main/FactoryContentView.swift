//
//  FactoryContentView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct FactoryContentView<G: Gesture>: View {

    // MARK: - Properties
    
    @Binding var selectedView: SelectedView
    
    var gameMode: String = ".groupActivity"
    
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
    
    private var settingsView: some View {
        SettingsView()
            .padding(.top, -64)
    }
    
    private var ranksView: some View {
        LeaderboardView()
            .padding(.top, -64)
            .padding(.bottom, 24)
    }
    
//    private var timedView: some View {
//        TimedView(board: GameLogic(size: 4))
//            .padding(.top, -64)
//            .padding(.bottom, 24)
//    }
    
    private var multiplayerView: some View {
        GameView(game: Factory.groupActivity())
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
    
    
    // MARK: - Private Methods
    
    @ViewBuilder
    private func currentView() -> some View {
        switch selectedView {
        case .game:
            tileBoardView
//        case .timed:
//            timedView
        case.multiplayer:
            multiplayerView
        case .ranks:
            ranksView
        case .stats:
            statsView
        case .settings:
            settingsView
        case .about:
            aboutView
        }
    }
}
