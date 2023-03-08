//
//  LeaderboardView.swift
//  Weather Merge
//
//  Created by Skyler Szijjarto on 1/16/23.
//

import SwiftUI
import CloudKit

struct LeaderboardView: View {
    
    // MARK: - Proeprties

    @State private var leaderboardData = [LeaderboardData]()
    @State private var searchTerm: String = ""
    @State private var leaderboardLoading: Bool = false
    @State private var leaderboardIsFiltered: Bool = false
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    // MARK: - Private Properties
    
    private var backgroundColor: Color {
        colorScheme == .light ? Color(red:0.43, green:0.43, blue:0.43, opacity: 1) : Color(red:0.33, green:0.33, blue:0.33, opacity: 1)
    }
    
    private var invertedBackgroundColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    // MARK: - Conformacne to View Protocol

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("leaderboardBackgroundColor"))
            VStack {
                HStack {
                    Spacer()
                    TextField("Search", text: $searchTerm, onEditingChanged: { isEditing in
                        if !isEditing && searchTerm.isEmpty {
                            endFilterLeaderboard()
                        } else {
                            filterLeaderboard()
                        }
                    })

                        .padding()
                        .foregroundColor(Color("leaderboardBorderColor"))
                        
                                    Button(action: {
                                        endFilterLeaderboard()
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing)
                                    }
                    Spacer()
                }
                .background(Color.primary.opacity(0.1))
                .cornerRadius(10)
                .padding()
                
                ZStack {
                    if leaderboardLoading == true {
                        VStack {
                            Text("Please allow up to 5 minutes for the leaderboard to update.")
                                .bold()
                                .font(.footnote)
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
//                                    .stroke(.blue, lineWidth: 4)
                                    .foregroundColor(Color("leaderboardBackgroundColor"))
                                    .shadow(color: Color(.black), radius: 10, x: 0, y: 0)
                                    .padding()
                                ProgressView()
                            }
                        }
                    } else {
                        if leaderboardIsFiltered {
                            List(leaderboardData.filter { $0.playerName.contains(searchTerm) }, id: \.self) { item in
                                HStack {
                                    Text("\(item.rank).")
                                    Text(item.playerName)
                                    Spacer()
                                    Text("\(item.score)")
                                }
                            }
                            
                            VStack {
                                Text("Please allow up to 5 minutes for the leaderboard to update.")
                                    .bold()
                                    .font(.footnote)
                                    .multilineTextAlignment(.center)
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25)
                                    //                                    .stroke(.blue, lineWidth: 4)
                                        .foregroundColor(Color("leaderboardBackgroundColor"))
                                        .shadow(color: Color(.black), radius: 5, x: 0, y: 0)
                                        .padding()
                                    VStack {
                                        ScrollView {
                                            ForEach(leaderboardData.filter { $0.playerName.contains(searchTerm) }, id: \.self) { data in
                                                VStack {
                                                    HStack {
                                                        Text("\(data.rank):")
                                                            .bold()
                                                            .font(.headline)
                                                        Text(data.playerName.capitalized)
                                                            .bold()
                                                            .font(.headline)
                                                        Spacer()
                                                        Text("\(data.score)")
                                                            .bold()
                                                            .font(.headline)
                                                    }
                                                    Divider()
                                                }
                                            }
                                            .padding()
                                        }
                                    }
                                    .padding()
                                }
                            }
                        } else {
                            VStack {
                                Text("Please allow up to 5 minutes for the leaderboard to update.")
                                    .bold()
                                    .font(.footnote)
                                    .multilineTextAlignment(.center)
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25)
                                    //                                    .stroke(.blue, lineWidth: 4)
                                        .foregroundColor(Color("leaderboardBackgroundColor"))
                                        .shadow(color: Color(.black), radius: 5, x: 0, y: 0)
                                        .padding()
                                    VStack {
                                        ScrollView {
                                            ForEach(leaderboardData, id: \.self) { data in
                                                VStack {
                                                    HStack {
                                                        Text("\(data.rank):")
                                                            .bold()
                                                            .font(.headline)
                                                        Text(data.playerName.capitalized)
                                                            .bold()
                                                            .font(.headline)
                                                        Spacer()
                                                        Text("\(data.score)")
                                                            .bold()
                                                            .font(.headline)
                                                    }
                                                    Divider()
                                                }
                                            }
                                            .padding()
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                }
            }
            .onAppear(perform: fetchLeaderboardData)
        }
    }
    
    // MARK: - Functions

    func filterLeaderboard() {
        leaderboardIsFiltered = true
    }
    
    func endFilterLeaderboard() {
        leaderboardIsFiltered = false
        self.searchTerm = ""
    }
    
    func fetchLeaderboardData() {
        leaderboardLoading = true
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Leaderboard", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "highScore", ascending: false)]

        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 100
        operation.recordFetchedBlock = { record in
            let playerName = record["playerName"] as! String
            let score = record["highScore"] as! Int
            let rank = self.leaderboardData.count + 1
            self.leaderboardData.append(LeaderboardData(recordID: record.recordID, playerName: playerName, rank: rank, score: score))
            leaderboardLoading = false
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

}

// MARK: - Previews

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
