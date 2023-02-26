//
//  CompositeView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI
import Combine
import CloudKit
import AVFoundation

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
    
    @State private var totalScore: Int = 1
    @State private var totalSwipes: Int = 0
    @State private var totalGames: Int = 0
    @State private var averageScore: Int = 0
    @State private var averageSwipes: Int = 0
    
    @State private var leaderboardData = [LeaderboardData]()
    let userName = UserDefaults.standard.string(forKey: "userName")
    let isAuthenticated = UserDefaults.standard.string(forKey: "isAuthenticated")
    
    @State private var resetWithScore: Bool = UserDefaults.standard.bool(forKey: "audioSound")
    
    @State private var selectedSound: String = UserDefaults.standard.string(forKey: "audioSound") ?? "default"
    @State private var audioSound = UserDefaults.standard.string(forKey: "audioSound")
    
//    @EnvironmentObject var adsViewModel: AdsViewModel
    
    @AppStorage(AppStorageKeys.audio.rawValue) var isAudioEnabled: Bool = true
    @AppStorage(AppStorageKeys.haptic.rawValue) var isHapticEnabled: Bool = true
    
    // MARK: - Initializers
    
    init(board: GameLogic) {
        self.logic = board
//        fetchHighScore()
        highScore = UserDefaults.standard.integer(forKey: "highScore")
        selectedSound = UserDefaults.standard.string(forKey: "audioSound") ?? "default"
        UserDefaults.standard.set("weather", forKey: "gameMode")
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
                        playSound()
                    } else if v.translation.width < -threshold {
                        // Move left
                        logic.move(.left)
                        playSound()
                    } else if v.translation.height > threshold {
                        // Move down
                        logic.move(.down)
                        playSound()
                    } else if v.translation.height < -threshold {
                        // Move up
                        logic.move(.up)
                        playSound()
                    }
                }
            }
        
            .onEnded { _ in
                ignoreGesture = false
            }
        return drag
    }
    
    // MARK: - Comformance to View Protocol
    
    var body: some View {
        NavigationView {
            if (isAuthenticated != nil) == false {
                LoginView(boardSize: 4)
            } else {
                GeometryReader { proxy in
                    ZStack(alignment: .top) {
                        VStack {
                                Group {
                                    self.compositeHeaderView(proxy)

                                    FactoryContentView(
                                        selectedView: $selectedView,
                                        gesture: gesture,
                                        gameLogic: logic,
                                        presentEndGameModal: $presentEndGameModal,
                                        presentSideMenu: $presentSideMenu
                                    )
                                    .onReceive(logic.$score) { (publishedScore) in
                                        if resetWithScore {
                                            score = 0
                                        }
                                        score = publishedScore
                                        if score > highScore {
                                            //                                        updateHighScore(newScore: score)
                                            highScore = score
                                            saveScore(playerName: "player", score: score)
                                            UserDefaults.standard.set(score, forKey: "highScore")
                                        }
                                    }
                                    .onReceive(logic.$mergeMultiplier) { (publishedScoreMultiplier) in
                                        scoreMultiplier = publishedScoreMultiplier
                                    }
                                    .onReceive(logic.$hasMoveMergedTiles) { hasMergedTiles in
                                        guard isAudioEnabled else { return }
                                        if audioSound == "default" {
                                            AudioSource.playCustom(source: .ding)
                                        } else if audioSound == "woosh" {
                                            AudioSource.playCustom(source: .woosh)
                                        } else if audioSound == "beep" {
                                            AudioSource.playCustom(source: .beep)
                                        } else if audioSound == "can" {
                                            AudioSource.playCustom(source: .can)
                                        } else if audioSound == "click" {
                                            AudioSource.playCustom(source: .click)
                                        } else if audioSound == "hit" {
                                            AudioSource.playCustom(source: .hit)
                                        } else if audioSound == "plant" {
                                            AudioSource.playCustom(source: .plant)
                                        } else if audioSound == "toy" {
                                            AudioSource.playCustom(source: .toy)
                                        } else if audioSound == "boing" {
                                            AudioSource.playCustom(source: .boing)
                                        } else if audioSound == "wood" {
                                            AudioSource.playCustom(source: .wood)
                                        } else {
                                            AudioSource.playCustom(source: .ding)
                                        }
                                        //                                    setTotalScore()
                                        Haptic.light()
                                    }
                                .blur(radius: (presentEndGameModal || presentSideMenu) ? 4 : 0)
                            }
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
        }
    }
    
    // MARK: - Methods
    
    private func compositeHeaderView(_ proxy: GeometryProxy) -> some View {
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
                if selectedView == .game /*|| selectedView == .timed*/ {
                    return true
                } else {
                    return false
                }
            }
        )
    }
    
    // MARK: - Private Functions
    
    private func resetGame() {
        logic.reset()
//        adsViewModel.showInterstitial = true
    }
    
    // MARK: - Stats Functions
    
//    func setTotalScore() {
//        if logic .hasMoveMergedTiles {
//            let totalScore = UserDefaults.standard.integer(forKey: "totalScore")
//            let scoreDifference = self.totalScore - self.score
//            self.totalScore = scoreDifference + totalScore
//            UserDefaults.standard.set(self.totalScore, forKey: "totalScore")
//            print(totalScore)
//        } else {
//            print("Tiles have not moved.")
//        }
//    }

    // MARK: - Score Functions
    
//    func saveHighScore(score: Int) {
//        let container = CKContainer(identifier: "iCloud.com.szijjarto.3096Game")
//        let publicDB = container.publicCloudDatabase
//
//        let newRecord = CKRecord(recordType: "highScore")
//        newRecord.setValue(score, forKey: "score")
//        newRecord.setValue(userName, forKey: "userName")
//
//        publicDB.save(newRecord) { (record, error) in
//            if let error = error {
//                print("Error saving high score to CloudKit: \(error)")
//            } else {
//                print("High score saved successfully to CloudKit")
//            }
//        }
//    }
//
//    func fetchHighScore() {
//        let container = CKContainer.default()
//        let publicDB = container.publicCloudDatabase
//        let predicate = NSPredicate(format: "username == %@", userName ?? "player")
//        let query = CKQuery(recordType: "highScore", predicate: predicate)
//        publicDB.perform(query, inZoneWith: nil) { (records, error) in
//            if let error = error {
//                print("Error fetching high score from CloudKit: \(error)")
//                return
//            }
//
//            guard let records = records else { return }
//            if records.isEmpty {
//                print("No high score records found for user: \(self.userName!).")
//                self.saveHighScore(score: self.highScore)
//                return
//            }
//            guard let highestScoreRecord = records.max(by: { ($0.value(forKey: "score") as! Int) < ($1.value(forKey: "score") as! Int) }) else { return }
//            let highScore = highestScoreRecord.value(forKey: "score") as! Int
//            DispatchQueue.main.async {
//                self.highScore = highScore
//            }
//        }
//    }

//    func createHighScoreRecord(score: Int) {
//        let highScoreRecord = CKRecord(recordType: "highScore")
//        highScoreRecord["username"] = (userName as! CKRecordValue)
//        highScoreRecord["score"] = score as CKRecordValue
//        let container = CKContainer.default()
//        let publicDB = container.publicCloudDatabase
//        publicDB.save(highScoreRecord) { (record, error) in
//            if let error = error {
//                print("Error saving high score record to CloudKit: \(error)")
//                return
//            }
//            print("High score record saved to CloudKit")
//        }
//    }
//
//    func updateHighScore(newScore: Int) {
//        let container = CKContainer.default()
//        let publicDB = container.publicCloudDatabase
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "highScore", predicate: predicate)
//        publicDB.perform(query, inZoneWith: nil) { (records, error) in
//            if let error = error {
//                print("Error fetching high score from CloudKit: \(error)")
//                return
//            }
//
//            guard records!.first(where: { $0.value(forKey: "username") as! String == self.userName! }) != nil else {
//                print("No high score records found for user: \(self.userName!).")
//                return
//            }
//            guard let records = records else { return }
//            guard let highestScoreRecord = records.max(by: { ($0.value(forKey: "score") as! Int) < ($1.value(forKey: "score") as! Int) }) else { return }
//            highestScoreRecord.setValue(newScore, forKey: "score")
//            publicDB.save(highestScoreRecord) { (record, error) in
//                if let error = error {
//                    print("Error updating high score on CloudKit: \(error)")
//                }
//            }
//        }
//    }

    func saveScore(playerName: String, score: Int) {
        let record = CKRecord(recordType: "Leaderboard")
        let playerName = UserDefaults.standard.string(forKey: "userName")
        record.setValue(playerName, forKey: "playerName")
        record.setValue(score, forKey: "highScore")

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
    
    // MARK: - Leaderboard Functions

    func fetchLeaderboardData() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Leaderboard", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 10 // limit the number of results
        operation.recordFetchedBlock = { record in
            //            let playerName = record["playerName"] as! String
            let playerName = UserDefaults.standard.string(forKey: "userName")
            let score = record["score"] as! Int
            let rank = self.leaderboardData.count + 1
            self.leaderboardData.append(LeaderboardData(recordID: record.recordID, playerName: playerName ?? "player", rank: rank, score: score))
//            print("Name: \(playerName) Score: \(score) High Score: \(highScore) Sound: \(selectedSound)")
        }
        operation.queryCompletionBlock = { [self] (cursor, error) in
            if let error = error {
                print("Error fetching leaderboard data: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.leaderboardData = self.leaderboardData.sorted(by: { $0.score > $1.score })
                    for (index, _) in self.leaderboardData.enumerated() {
                        self.leaderboardData[index].rank = index + 1
                    }
                }
            }
        }
        let container = CKContainer(identifier: "iCloud.com.szijjarto.3096Game")
        let database = container.publicCloudDatabase
        database.add(operation)
    }
    
    private func playSound() {
        if isAudioEnabled {
            if selectedSound == "default" {
                AudioSource.play(from: .ding)
            } else if selectedSound == "sound1" {
//                AudioSource.play(from: .new)
            }
        }
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
