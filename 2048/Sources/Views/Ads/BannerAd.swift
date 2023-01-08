//
//  BannerAd.swift
//  2048
//
//  Created by Skyler Szijjarto on 1/8/23.
//

import SwiftUI
import GoogleMobileAds

// Banner Ad

struct BannerAd: UIViewRepresentable {
    
    var unitID: String
    
    func makeCoordinator () -> Coordinator {
        // Delegates
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> GADBannerView{
        
        let adView = GADBannerView(adSize: GADAdSizeBanner)
        
        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.getRootViewControler()
        adView.delegate = context.coordinator
        adView.load(GADRequest())
        
        return adView

    }
    
    func updateUIView(_ uiview: GADBannerView, context: Context) {
        
    }
    
    class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
          print("bannerViewDidReceiveAd")
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
          print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
          print("bannerViewDidRecordImpression")
        }

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
          print("bannerViewWillPresentScreen")
        }

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
          print("bannerViewWillDIsmissScreen")
        }

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
          print("bannerViewDidDismissScreen")
        }
    }
}

// Extending to Get Root View
extension UIApplication {
    func getRootViewControler()->UIViewController {
        
        guard let screen = self.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
