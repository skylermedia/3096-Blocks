//
//  LeaderboardView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/16/23.
//

//import SwiftUI
//import CloudKit
//
//struct LeaderboardView: View {
//    @State private var leaderboardData = [LeaderboardData]()
//    @State private var searchTerm: String = ""
//    
//    var body: some View {
//        VStack {
//            HStack {
//                TextField("Search", text: $searchTerm)
//                    .padding()
//                    .background(Color.gray)
//                    .cornerRadius(8)
//                Button(action: {
//                    self.searchTerm = ""
//                }) {
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundColor(.gray)
//                }
//            }
//            List(leaderboardData.filter { $0.playerName.contains(searchTerm) }, id: \.self) { item in
//                HStack {
//                    Text("\(item.rank).")
//                    Text(item.playerName)
//                    Spacer()
//                    Text("\(item.score)")
//                }
//            }
//        }
//        .onAppear(perform: fetchLeaderboardData)
//    }
//    
//    func saveScore(playerName: String, score: Int) {
//        let record = CKRecord(recordType: "Leaderboard")
//        record.setValue(playerName, forKey: "playerName")
//        record.setValue(score, forKey: "score")
//
//        let container = CKContainer.default()
//        let database = container.publicCloudDatabase
//        database.save(record) { (savedRecord, error) in
//            if let error = error {
//                print("Error saving score: \(error)")
//            } else {
//                self.fetchLeaderboardData()
//            }
//        }
//    }
//    
//    func fetchLeaderboardData() {
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "Leaderboard", predicate: predicate)
//        query.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
//        
//        let operation = CKQueryOperation(query: query)
//        operation.resultsLimit = 10 // limit the number of results
//        operation.recordFetchedBlock = { record in
//            let playerName = record["playerName"] as! String
//            let score = record["score"] as! Int
//            let rank = self.leaderboardData.count + 1
//            self.leaderboardData.append(LeaderboardData(recordID: record.recordID, playerName: playerName, rank: rank, score: score))
//        }
//        operation.queryCompletionBlock = { [self] (cursor, error) in
//            if let error = error {
//                print("Error fetching leaderboard data: \(error)")
//            } else {
//                DispatchQueue.main.async {
//                    self.leaderboardData = self.leaderboardData.sorted(by: { $0.score > $1.score })
//                    for (index, data) in self.leaderboardData.enumerated() {
//                        self.leaderboardData[index].rank = index + 1
//                    }
//                }
//            }
//        }
//        let container = CKContainer.default()
//        let database = container.publicCloudDatabase
//        database.add(operation)
//    }
//}
//
//
//struct LeaderboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeaderboardView()
//    }
//}
