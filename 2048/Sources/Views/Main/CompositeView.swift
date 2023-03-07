//
//  CompositeView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI
import Combine
import CloudKit
import AVFoundation

struct CompositeView: View {
    
    // MARK: - Environment
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.colorSchemeBackgroundTheme) private var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    //    @EnvironmentObject var adsViewModel: AdsViewModel
    
    // MARK: - Observed Objects
    
    @ObservedObject private var logic: GameLogic
    
    // MARK: - Proeprties
    
    @State private var ignoreGesture = false
    @State private var presentEndGameModal = false
    @State private var hasGameEnded = false
    @State private var viewState = CGSize.zero
    
    @State private var sideMenuViewState = CGSize.zero
    @State private var presentSideMenu = false
    
    @State private var selectedView: SelectedView = .game
    @State private var score: Int = 0
    @State private var resetNextMove: Bool = UserDefaults.standard.bool(forKey: "resetNextMove")
    @State private var level: Int = UserDefaults.standard.integer(forKey: "level")
    @State private var scoreMultiplier: Int = 0
    
    @State private var showLevelCompletedView: Bool = false
    
    @State private var showNextLevelPopup: Bool = false
    @State private var isShowingLevelCompletedView: Bool = false
    
    @State private var leaderboardData = [LeaderboardData]()
    let userName = UserDefaults.standard.string(forKey: "userName")
    let isAuthenticated = UserDefaults.standard.string(forKey: "isAuthenticated")
    let hasPlayedBefore = UserDefaults.standard.string(forKey: "hasPlayedBefore")
    
    @State private var resetWithScore: Bool = UserDefaults.standard.bool(forKey: "resetWithScore")
    
    @State private var unlockedLevels = Set(UserDefaults.standard.array(forKey: "unlockedLevels") as? [Int] ?? [0, 1])
    
    // MARK: - App Storage
    
    @AppStorage("highScore") var highScore: Int = 0
//    @AppStorage("scoreGoal") var scoreGoal: Int = UserDefaults.standard.integer(forKey: "scoreGoal")
    
    @AppStorage("scoreGoal") var scoreGoal: Int = 0
    
    // MARK: - Login
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @AppStorage("username") var currentUserUsername: String?
    
    // MARK: - Sound Settings
    
    @AppStorage(AppStorageKeys.audio.rawValue) var isAudioEnabled: Bool = true
    @AppStorage(AppStorageKeys.haptic.rawValue) var isHapticEnabled: Bool = true
    @AppStorage("gameSound") var gameSound: String = "default"
    
    // MARK: - Stats
    
    @AppStorage("lifetimeScore") var lifetimeScore: Int = 0
    @AppStorage("lifetimeSwipes") var lifetimeSwipes: Int = 0
    @AppStorage("lifetimeGames") var lifetimeGames: Int = 0
    
    // MARK: - Initializers
    
    init(board: GameLogic) {
        self.logic = board
        resetNextMove = false
        UserDefaults.standard.set("symbols", forKey: "gameMode")
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
            if currentUserSignedIn == false {
                BetaLoginView()
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
                                    
                                    if resetNextMove == true {
                                        resetGame()
                                        resetNextMove = false
                                        UserDefaults.standard.set(resetNextMove, forKey: "resetNextMove")
                                    }
                                    
                                    if publishedScore > scoreGoal {
                                        showLevelCompletedView = true
                                    }
                                    
                                    score = publishedScore
                                    if publishedScore > highScore {
                                        //                                        updateHighScore(newScore: score)
                                        saveScore(playerName: "player", score: score)
                                        highScore = score
                                        saveScore(playerName: "player", score: score)
                                        UserDefaults.standard.set(highScore, forKey: "highScore")
                                    }
                                }
                                .onReceive(logic.$mergeMultiplier) { (publishedScoreMultiplier) in
                                    scoreMultiplier = publishedScoreMultiplier
                                }
                                .onReceive(logic.$hasMoveMergedTiles) { hasMergedTiles in
                                    guard isAudioEnabled else { return }
                                    if gameSound == "default" {
                                        AudioSource.playCustom(source: .ding)
                                    } else if gameSound == "woosh" {
                                        AudioSource.playCustom(source: .woosh)
                                    } else if gameSound == "beep" {
                                        AudioSource.playCustom(source: .beep)
                                    } else if gameSound == "can" {
                                        AudioSource.playCustom(source: .can)
                                    } else if gameSound == "click" {
                                        AudioSource.playCustom(source: .click)
                                    } else if gameSound == "hit" {
                                        AudioSource.playCustom(source: .hit)
                                    } else if gameSound == "plant" {
                                        AudioSource.playCustom(source: .plant)
                                    } else if gameSound == "toy" {
                                        AudioSource.playCustom(source: .toy)
                                    } else if gameSound == "boing" {
                                        AudioSource.playCustom(source: .boing)
                                    } else if gameSound == "wood" {
                                        AudioSource.playCustom(source: .wood)
                                    } else {
                                        AudioSource.playCustom(source: .ding)
                                    }
                                    
                                    updateStats()
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
                            highScore: $highScore,
                            scoreGoal: $scoreGoal,
                            level: $level,
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
        .sheet(isPresented: $showLevelCompletedView) {
            VStack {
                Text("Level Completed")
                    .padding(.top)
                    .font(.largeTitle.bold())
                Spacer()
                instructionsText(title: "In Progress", text: "")
                instructionsText(title: "Warning!", text: "Please click 'CONTINUE TO NEXT LEVEL'")
                instructionsText(title: "DO NOT SWIPE DOWN!", text: "Do not swipe down. It will break the game. Fix coming soon")
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showLevelCompletedView = false
                        level = level + 1
                        
                        self.level = level
                        
                        switch level {
                        case 0:
                            scoreGoal = 100
//                            let userUnlockedLevels = [0]
                        case 1:
                            scoreGoal = 1000
//                            let userUnlockedLevels = [0, 1]
                        case 2:
                            scoreGoal = 25000
//                            let userUnlockedLevels = [0, 1, 2]
                        case 3:
                            scoreGoal = 50000
//                            let userUnlockedLevels = [0, 1, 2, 3]
                        case 4:
                            scoreGoal = 75000
//                            let userUnlockedLevels = [0, 1, 2, 3, 4]
                        case 5:
                            scoreGoal = 100000
//                            let userUnlockedLevels = [0, 1, 2, 3, 4, 5]
                        case 6:
                            scoreGoal = 150000
//                            let userUnlockedLevels = [0, 1, 2, 3, 4, 5, 6]
                        case 7:
                            scoreGoal = 250000
//                            let userUnlockedLevels = [0, 1, 2, 3, 4, 5, 6, 7]
                        default:
                            scoreGoal = 100
                        }
                        
                        // Store updated unlocked levels array in AppStorage
                        UserDefaults.standard.set(unlockedLevels, forKey: "unlockedLevels")
                        UserDefaults.standard.set(scoreGoal, forKey: "scoreGoal")
                        UserDefaults.standard.set(level, forKey: "level")
                    }) {
                        VStack {
                            Image(systemName: "x.circle.fill")
                                .font(.largeTitle.bold())
                                .foregroundColor(.primary)
                            Text("Continue to Next Level")
                                .foregroundColor(.primary)
                                .font(.headline.bold())
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    // MARK: - Methods
    
    private func compositeHeaderView(_ proxy: GeometryProxy) -> some View {
        HeaderView(
            proxy: proxy,
            showSideMenu: $presentSideMenu,
            title: selectedView.title,
            score: $score,
            scoreMultiplier: $scoreMultiplier,
            highScore: $highScore,
            scoreGoal: scoreGoal,
            level: level,
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
    
    func updateStats() {
        DispatchQueue.global().async {
            // Update Lifetime Swipes
            lifetimeSwipes = lifetimeSwipes + 1
            
        }
    }
    
    // MARK: - Score Functions
    
    //    func saveHighScore(score: Int) {
    //        let container = CKContainer.default()
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
        DispatchQueue.global().async {
            let record = CKRecord(recordType: "Leaderboard")
            let playerName = currentUserUsername
            record.setValue(playerName, forKey: "userName")
            record.setValue(score, forKey: "highScore")
            
            let container = CKContainer(identifier: "iCloud.szijjarto.WeatherMerge")
            let database = container.publicCloudDatabase
            database.save(record) { (savedRecord, error) in
                if let error = error {
                    print("Error saving score: \(error)")
                } else {
                    
                }
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
        let container = CKContainer.default()
        let database = container.publicCloudDatabase
        database.add(operation)
    }
    
    private func playSound() {
        if isAudioEnabled {
            if gameSound == "default" {
                AudioSource.play(from: .ding)
            } else if gameSound == "sound1" {
                //                AudioSource.play(from: .new)
            }
        }
    }
}

// MARK: - Previews

struct CompositeView_Previews : PreviewProvider {
    static var previews: some View {
        CompositeView(board: GameLogic(size: BoardSize.fourByFour.rawValue))
    }
}
