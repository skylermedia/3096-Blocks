//
//  2048App.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI
import GoogleMobileAds

@main
struct TwoZeroFourEightApp: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    class AppDelegate: UIResponder, UIApplicationDelegate {

      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GADMobileAds.sharedInstance().start(completionHandler: nil)

        return true
      }

    }
    private var mainView: some View {
        let rawValue = UserDefaults.standard.integer(forKey: Notification.Name.gameBoardSize.rawValue)
        let boardSize = BoardSize(rawValue: rawValue) ?? BoardSize.fourByFour
        let initialBoardSizeRawValue = boardSize.rawValue
        
        return CompositeView(board: GameLogic(size: initialBoardSizeRawValue))
    }
    
    var body: some Scene {
        WindowGroup {
            mainView
        }
    }
}
