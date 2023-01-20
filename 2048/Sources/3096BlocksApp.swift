//
//  3096BlocksApp.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI
import GoogleMobileAds

@main
struct TwoZeroFourEightApp: App {
    class AppDelegate: UIResponder, UIApplicationDelegate {

      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

          DispatchQueue.global().async {
                GADMobileAds.sharedInstance().start(completionHandler: nil)
              if UserDefaults.standard.string(forKey: "audioSound") == nil {
                  UserDefaults.standard.set("default", forKey: "audioSound")
              }
          }
          //        UserDefaults.standard.register(defaults: ["playerName" : "Unknown player"])


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
