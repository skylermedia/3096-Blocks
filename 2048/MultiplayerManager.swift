////
////  MultiplayerManager.swift
////  Weather Merge
////
////  Created by Skyler Szijjarto on 2/18/23.
////
//
//import Foundation
//import MultipeerConnectivity
//
//class MultiplayerManager: NSObject, MCSessionDelegate {
//    private let session: MCSession
//    private let advertiser: MCNearbyServiceAdvertiser
//    private let browser: MCNearbyServiceBrowser
//    
//    /*
//    Button {
//        startAdvertisingAndBrowsing()
//            } label: {
//                Text("Play")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 10)
//                    .background(Capsule())
//            }
//     */
//    
//    init(peerID: MCPeerID) {
//        session = MCSession(peer: peerID)
//        advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "my-game-service")
//        browser = MCNearbyServiceBrowser(peer: peerID, serviceType: "my-game-service")
//        
//        super.init()
//        
//        session.delegate = self
//        advertiser.delegate = self
//        browser.delegate = self
//    }
//    
//    func startAdvertisingAndBrowsing() {
//        advertiser.startAdvertisingPeer()
//        browser.startBrowsingForPeers()
//    }
//    
//    // MCSessionDelegate methods
//    @objc(session:peer:didChangeState:) func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
//        // Handle changes in peer state (connected, disconnected, etc.)
//    }
//
//    @objc(session:didReceiveData:fromPeer:) func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        // Handle incoming data from other players
//    }
//
//    @objc(session:didReceiveStream:withName:fromPeer:) func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
//        // Handle incoming streams from other players
//    }
//
//    @objc(session:didStartReceivingResourceWithName:fromPeer:withProgress:) func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
//        // Handle incoming resources from other players
//    }
//
//    @objc(session:didFinishReceivingResourceWithName:fromPeer:atURL:withError:) func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
//        // Handle finished receiving resources from other players
//    }
//
//    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
//        // Handle received certificates from other players
//    }
//}
//
//// MCNearbyServiceAdvertiserDelegate methods
//extension MultiplayerManager: MCNearbyServiceAdvertiserDelegate {
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//        // Handle incoming invitations from other players
//    }
//
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
//        // Handle errors when advertising fails
//    }
//}
//
//// MCNearbyServiceBrowserDelegate methods
//extension MultiplayerManager: MCNearbyServiceBrowserDelegate {
//    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
//        // Handle found peers
//    }
//
//    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        // Handle lost peers
//    }
//
//    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
//        // Handle errors when browsing fails
//    }
//}
//
//// Convenience method for sending data to connected peers
//extension MultiplayerManager {
//    func sendDataToPeers(_ data: Data, mode: MCSessionSendDataMode) {
//        do {
//            try session.send(data, toPeers: session.connectedPeers, with: mode)
//        } catch {
//            // Handle error sending data
//        }
//    }
//}
//
