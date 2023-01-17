//
//  CompositeView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI
import Combine
import CloudKit

struct CompositeView: View {
    
    // MARK: - Proeprties
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @State private var ignoreGesture = false
    @State private var presentEndGameModal = false
    @State private var hasGameEnded = false
    @State private var viewState = CGSize.zero
    
    @State private var sideMenuViewState = CGSize.zero
    @State private var presentSideMenu = false
    
    @ObservedObject private var logic: GameLogic
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.colorSchemeBackgroundTheme) private var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme
    
    @State private var selectedView: SelectedView = .game
    @State private var score: Int = 0
    @State private var highScore: Int = 0
    @State private var scoreMultiplier: Int = 0
    
    @State private var leaderboardData = [LeaderboardData]()
    
    @AppStorage(AppStorageKeys.audio.rawValue) var isAudioEnabled: Bool = true
    @AppStorage(AppStorageKeys.haptic.rawValue) var isHapticEnabled: Bool = true
    
    // MARK: - Initializers
    
    init(board: GameLogic) {
        self.logic = board
        highScore = UserDefaults.standard.integer(forKey: "highScore")
    }
    
    // MARK: - Drag Gesture
    
    private var gesture: some Gesture {
        let threshold: CGFloat = 25
        
        let drag = DragGesture()
            .onChanged { v in
                guard !ignoreGesture else { return }
                
                guard abs(v.translation.width) > threshold ||
                    abs(v.translation.height) > threshold else {
                        return
                }
                withTransaction(Transaction()) {
                    ignoreGesture = true
                    
                    if v.translation.width > threshold {
                        // Move right
                        logic.move(.right)
                    } else if v.translation.width < -threshold {
                        // Move left
                        logic.move(.left)
                    } else if v.translation.height > threshold {
                        // Move down
                        logic.move(.down)
                    } else if v.translation.height < -threshold {
                        // Move up
                        logic.move(.up)
                    }
                }
        }
        .onEnded { _ in
            ignoreGesture = false
        }
        return drag
    }
    
    // MARK: - Comformance to View protocol
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VStack {
                    Group {
                        self.headerView(proxy)

                        FactoryContentView(
                            selectedView: $selectedView,
                            gesture: gesture,
                            gameLogic: logic,
                            presentEndGameModal: $presentEndGameModal,
                            presentSideMenu: $presentSideMenu
                        )
                        .onReceive(logic.$score) { (publishedScore) in
                            score = publishedScore
                            if score > highScore {
                                highScore = score
                                UserDefaults.standard.set(highScore, forKey: "highScore")
                                saveScore(playerName: "player", score: score)
                            }
                        }
                                                .onReceive(logic.$mergeMultiplier) { (publishedScoreMultiplier) in
                                                    scoreMultiplier = publishedScoreMultiplier
                                                }
                                                .onReceive(logic.$hasMoveMergedTiles) { hasMergedTiles in
                                                    guard isAudioEnabled else { return }
                                                    AudioSource.play(condition: hasMergedTiles)
                                                    Haptic.light()
                                                }                    }
                    .blur(radius: (presentEndGameModal || presentSideMenu) ? 4 : 0)
                }
                .modifier(RoundedClippedBackground(backgroundColor: colorSchemeBackgroundTheme.backgroundColor(for: colorScheme),
                                                   proxy: proxy))
                .modifier(
                    MainViewModifier(
                        proxy: proxy,
                        presentEndGameModal: $presentEndGameModal,
                        presentSideMenu: $presentSideMenu,
                        viewState: $viewState
                    )
                )
                .onTapGesture {
                    guard !hasGameEnded else { return } // Disable on tap dismissal of the end game modal view
                        
                        withAnimation(.modalSpring) {
                            presentEndGameModal = false
                            presentSideMenu = false
                        }
                }
                .onReceive(logic.$noPossibleMove) { (publisher) in
                    let hasGameEnded = logic.noPossibleMove
                    self.hasGameEnded = hasGameEnded
                    
                    withAnimation(.modalSpring) {
                        self.presentEndGameModal = hasGameEnded
                    }
                }
                
                GameStateBottomView(
                    hasGameEnded: $hasGameEnded,
                    presentEndGameModal: $presentEndGameModal,
                    sideMenuViewState: $sideMenuViewState,
                    score: $score,
                    resetGame: resetGame
                )
                CompositeSideView(
                    selectedView: $selectedView,
                    sideMenuViewState: $sideMenuViewState,
                    presentSideMenu: $presentSideMenu
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
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
    
    private func resetGame() {
        logic.reset()
    }
// MARK: - Leaderboard Functions
    
    func saveScore(playerName: String, score: Int) {
        let record = CKRecord(recordType: "Leaderboard")
        record.setValue(playerName, forKey: "playerName")
        record.setValue(score, forKey: "score")

        let container = CKContainer.default()
        let database = container.publicCloudDatabase
        database.save(record) { (savedRecord, error) in
            if let error = error {
                print("Error saving score: \(error)")
            } else {
                self.fetchLeaderboardData()
            }
        }
    }
    
    func fetchLeaderboardData() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Leaderboard", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 10 // limit the number of results
        operation.recordFetchedBlock = { record in
            let playerName = record["playerName"] as! String
            let score = record["score"] as! Int
            let rank = self.leaderboardData.count + 1
            self.leaderboardData.append(LeaderboardData(recordID: record.recordID, playerName: playerName, rank: rank, score: score))
        }
        operation.queryCompletionBlock = { [self] (cursor, error) in
            if let error = error {
                print("Error fetching leaderboard data: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.leaderboardData = self.leaderboardData.sorted(by: { $0.score > $1.score })
                    for (index, data) in self.leaderboardData.enumerated() {
                        self.leaderboardData[index].rank = index + 1
                    }
                }
            }
        }
        let container = CKContainer(identifier: "iCloud.com.szijjarto.3096Game")
        let database = container.publicCloudDatabase
        database.add(operation)
    }
}

// MARK: - Leaderboard
struct LeaderboardView: View {
    
    @State private var leaderboardData = [LeaderboardData]()
    @State private var searchTerm: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $searchTerm)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(8)
                Button(action: {
                    self.searchTerm = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            List {
                ForEach(leaderboardData, id: \.self) { data in
                    HStack {
                        Text("\(data.rank).")
                        Text(data.playerName)
                        Spacer()
                        Text("\(data.score)")
                    }
                }
                /*
                 List(leaderboardData.filter { $0.playerName.contains(searchTerm) }, id: \.self) { item in
                 HStack {
                     Text("\(item.rank).")
                     Text(item.playerName)
                     Spacer()
                     Text("\(item.score)")
                 }
                 */
            }
        }
        .onAppear(perform: fetchLeaderboardData)
    }
    
    func fetchLeaderboardData() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Leaderboard", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 10 // limit the number of results
        operation.recordFetchedBlock = { record in
            let playerName = record["playerName"] as! String
            let score = record["score"] as! Int
            let rank = self.leaderboardData.count + 1
            self.leaderboardData.append(LeaderboardData(recordID: record.recordID, playerName: playerName, rank: rank, score: score))
        }
        operation.queryCompletionBlock = { [self] (cursor, error) in
            if let error = error {
                print("Error fetching leaderboard data: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.leaderboardData = self.leaderboardData.sorted(by: { $0.score > $1.score })
                    for (index, data) in self.leaderboardData.enumerated() {
                        self.leaderboardData[index].rank = index + 1
                    }
                }
            }
        }
        let container = CKContainer(identifier: "iCloud.com.szijjarto.3096Game")
        let database = container.publicCloudDatabase
        database.add(operation)
    }
}

// MARK: - Previews

struct CompositeView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CompositeView(
                board: GameLogic(size: BoardSize.fourByFour.rawValue)
            )
            .colorScheme(.dark)
    
            CompositeView(
                board: GameLogic(size: BoardSize.fourByFour.rawValue)
            )
            .colorScheme(.light)
        }
    }
}
