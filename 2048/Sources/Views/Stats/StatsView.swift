//
//  StatsView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/19/23.
//

import SwiftUI
import CloudKit

struct StatsView: View {
    
    // MARK: - Proeprties
    
    @State private var leaderboardData = [LeaderboardData]()
    @State private var searchTerm: String = ""
    @State private var leaderboardLoading: Bool = false
    @State private var leaderboardIsFiltered: Bool = false
    
    @State private var totalScore: Int = UserDefaults.standard.integer(forKey: "totalScore")
    @State private var totalSwipes: Int = 0
    @State private var totalGames: Int = 0
    @State private var averageScore: Int = 0
    @State private var averageSwipes: Int = 0
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    // MARK: - App Storage
    
    @AppStorage("lifetimeScore") var lifetimeScore: Int = 0
    @AppStorage("lifetimeSwipes") var lifetimeSwipes: Int = 0
    @AppStorage("lifetimeGames") var lifetimeGames: Int = 0
    
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
                ZStack {
                    if leaderboardLoading == true {
                        VStack {
                            Text("Please allow up to 5 minutes for the leaderboard to update.")
                                .bold()
                                .font(.headline)
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
                        VStack {
                            Text("The stats view is currenly in development and may not show accurate (if any) information.")
                                .bold()
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                //                                                                        .stroke(.blue, lineWidth: 4)
                                    .foregroundColor(Color("leaderboardBackgroundColor"))
                                    .shadow(color: Color(.black), radius: 5, x: 0, y: 0)
                                    .padding()
                                VStack {
                                    Spacer()
                                    HStack {
                                        Text("Lifetime")
                                            .font(Font.system(.largeTitle, design: .monospaced).weight(.black))
                                            .foregroundColor(Color(red:0.29, green:0.29, blue:0.29, opacity: 1.00))
                                    }
                                    HStack {
                                        Spacer()
                                        VStack {
//                                            Text("Total Score: ")
//                                                .font(Font.system(.title2, design: .monospaced).weight(.black))
//                                                .foregroundColor(Color(red:0.29, green:0.29, blue:0.29, opacity: 1.00))
//                                                .strikethrough()
//                                            Text("\(lifetimeScore)")
//                                                .font(Font.system(.title2, design: .monospaced).weight(.black))
//                                                .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
//                                                .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
//                                                .animation(.modalSpring)
                                        }
                                        Spacer()
                                    }
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Text("Lifetime Swipes: ")
                                                .font(Font.system(.title, design: .monospaced).weight(.black))
                                                .foregroundColor(Color(red:0.29, green:0.29, blue:0.29, opacity: 1.00))
                                            Text("\(lifetimeSwipes)")
                                                .font(Font.system(.title, design: .monospaced).weight(.black))
                                                .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
                                                .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                                                .animation(.modalSpring)
                                        }
                                        Spacer()
                                    }
                                    HStack {
                                        Spacer()
                                        VStack {
//                                            Text("Lifetime Games: ")
//                                                .font(Font.system(.title, design: .monospaced).weight(.black))
//                                                .foregroundColor(Color(red:0.29, green:0.29, blue:0.29, opacity: 1.00))
//                                                .strikethrough()
//                                            Text("\(lifetimeGames)")
//                                                .font(Font.system(.title2, design: .monospaced).weight(.black))
//                                                .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
//                                                .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
//                                                .animation(.modalSpring)
                                        }
                                        Spacer()
                                    }
//                                    Divider()
                                    // Averages
//                                    Text("Averages")
//                                        .font(Font.system(.largeTitle, design: .monospaced).weight(.black))
//                                        .foregroundColor(Color(red:0.29, green:0.29, blue:0.29, opacity: 1.00))
//                                    HStack {
//                                        Spacer()
//                                        Text("Average Score:")
//                                            .font(Font.system(.title, design: .monospaced).weight(.black))
//                                            .foregroundColor(Color(red:0.29, green:0.29, blue:0.29, opacity: 1.00))
//                                        Text("\(averageScore)")
//                                            .font(Font.system(.title, design: .monospaced).weight(.black))
//                                            .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
//                                            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
//                                            .animation(.modalSpring)
//                                        Spacer()
//                                    }
//                                    HStack {
//                                        Spacer()
//                                        Text("Average Swipes:")
//                                            .font(Font.system(.title, design: .monospaced).weight(.black))
//                                            .foregroundColor(Color(red:0.29, green:0.29, blue:0.29, opacity: 1.00))
//                                        Text("\(averageSwipes)")
//                                            .font(Font.system(.title, design: .monospaced).weight(.black))
//                                            .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
//                                            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
//                                            .animation(.modalSpring)
                                        Spacer()
//                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
