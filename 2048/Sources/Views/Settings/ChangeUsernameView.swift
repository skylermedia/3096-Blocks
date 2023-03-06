//
//  ChangeUsernameView.swift
//  Merge
//
//  Created by Skyler Szijjarto on 3/3/23.
//

import SwiftUI

struct ChangeUsernameView: View {
    
    // MARK: - Environment
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    // MARK: - Properties
    
    @AppStorage("username") var currentUserUsername: String?
    @State private var newUsername: String = ""
    
    // MARK: - Colors
    
    private var textColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    private var usernameTextColor: Color {
        colorScheme == .light ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        VStack {
            Spacer()
            Text("Do not use personal information in your username (full name, phone number, etc…).")
                .padding(.horizontal)
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(textColor)
            Divider()
                .padding([.horizontal, .bottom])
            HStack {
                Spacer()
                TextField(currentUserUsername ?? "Username", text: $newUsername)
                    .font(.body.bold())
                    .padding()
                    .foregroundColor(usernameTextColor)
                    .background(backgroundColor)
                    .cornerRadius(25)
                Spacer()
            }
            if #available(iOS 15.0, *) {
                Button("Submit") {
                    setUserName()
                }
                .foregroundColor(.primary)
                .padding()
                .buttonStyle(.borderedProminent)
            } else {
                Button("Submit") {
                    setUserName()
                }
                .foregroundColor(.primary)
                .padding()
                .buttonStyle(.automatic)
            }
            Spacer()
        }
    }
    
    // MARK: - Functions
    
    func setUserName() {
        currentUserUsername = newUsername
        print("New Username: \(currentUserUsername ?? "Username")")
    }
    
}

// MARK: - Previews

struct ChangeUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
                .preferredColorScheme(.dark)
            SettingsView()
                .preferredColorScheme(.light)
        }
    }
}
