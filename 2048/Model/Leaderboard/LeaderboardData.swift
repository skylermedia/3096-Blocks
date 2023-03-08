//
//  LeaderboardData.swift
//  Weather Merge
//
//  Created by Skyler Szijjarto on 1/16/23.
//

import SwiftUI
import CloudKit
import Foundation

struct LeaderboardData: Identifiable, Hashable {
    var id = UUID()
    var playerName: String
    var rank: Int
    var score: Int
    //    var leaderboardData = [LeaderboardData(playerName: "Player1", rank: 1, score: 1000),
    //                          LeaderboardData(playerName: "Player2", rank: 2, score: 900),
    //                          LeaderboardData(playerName: "Player3", rank: 3, score: 800)]
    
    init(recordID: CKRecord.ID, playerName: String, rank: Int, score: Int) {
        self.id = UUID(uuidString: recordID.recordName)!
        self.playerName = playerName
        self.rank = rank
        self.score = score
    }
}
