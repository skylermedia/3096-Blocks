//
//  3096BlocksApp.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI
//import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class AdsManager: NSObject, ObservableObject {
    
    private struct AdMobConstant {
        static let interstitial1ID = "ca-app-pub-3940256099942544/1033173712"
    }
    
//    final class Interstitial: NSObject, GADFullScreenContentDelegate, ObservableObject {

//        private var interstitial: GADInterstitialAd?
        
//        override init() {
//            super.init()
//            requestInterstitialAds()
//        }

//        func requestInterstitialAds() {
////            let request = GADRequest()
//            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
////                GADInterstitialAd.load(withAdUnitID: AdMobConstant.interstitial1ID, request: request, completionHandler: { [self] ad, error in
//                    if let error = error {
//                        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//                        return
//                    }
//                    interstitial = ad
//                    interstitial?.fullScreenContentDelegate = self
//                })
//            })
        }
//        func showAd() {
//            let root = UIApplication.shared.windows.last?.rootViewController
//            if let fullScreenAds = interstitial {
//                fullScreenAds.present(fromRootViewController: root!)
//            } else {
//                print("not ready")
//            }
//        }
        
//    }
    
    
//}

//class AdsViewModel: ObservableObject {
//    static let shared = AdsViewModel()
////    @Published var interstitial = AdsManager.Interstitial()
//    @Published var showInterstitial = false {
//        didSet {
//            if showInterstitial {
//                interstitial.showAd()
//                showInterstitial = false
//            } else {
//                interstitial.requestInterstitialAds()
//            }
//        }
//    }
//}

@main
struct TwoZeroFourEightApp: App {
//    let adsVM = AdsViewModel.shared

    class AppDelegate: UIResponder, UIApplicationDelegate {

      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

          DispatchQueue.global().async {
//                GADMobileAds.sharedInstance().start(completionHandler: nil)
              if UserDefaults.standard.string(forKey: "audioSound") == nil {
                  UserDefaults.standard.set("default", forKey: "audioSound")
              }
          }
          //        UserDefaults.standard.register(defaults: ["playerName" : "Unknown player"])


        return true
      }

    }
    
    func gameMode() {
        UserDefaults.standard.set("letter", forKey: "gameMode")
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
//                .environmentObject(adsVM)
        }
    }
}
