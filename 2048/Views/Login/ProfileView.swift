//
//  ProfileView.swift
//  Merge
//
//  Created by Skyler Szijjarto on 3/4/23.
//

import SwiftUI

struct ProfileView: View {
    
    // MARK: - Environment
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    // MARK: - App Storage
    
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("username") var currentUserUsername: String?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        profileView
    }
    
    // MARK: - Functions
    
    func signOut() {
        currentUserName = nil
        currentUserAge = nil
        currentUserUsername = nil
        currentUserGender = nil
        withAnimation(.spring()) {
            currentUserSignedIn = false
        }
    }
    
}

// MARK: - Extensions

extension ProfileView {
    
    // MARK: - Colors
    
    private var textColor: Color {
        colorScheme == .light ? .black : .white
    }
    
    private var buttonTextColor: Color {
        colorScheme == .light ? .white : .black
    }
    
    private var backgroundColor: Color {
        colorScheme == .light ? .white.opacity(0.8) : .black.opacity(0.8)
    }
    
    private var buttonColor: Color {
        colorScheme == .light ? .black : .white
    }
    
    // MARK: - Views
    
    private var signOutButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .background(buttonColor)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    signOut()
                }
            
            Text("SIGN OUT")
                .foregroundColor(buttonTextColor)
                .font(.headline)
        }
    }
    
    private var userInformation: some View {
        VStack {
            Text("Name: \(currentUserName ?? "Your name should be here. Please email support@skyler.media for assistance.")")
            Text("Username: \(currentUserUsername ?? "Your name should be here. Please email support@skyler.media for assistance.")")
            Text("Age: \(currentUserAge ?? 0)")
            //            Text("Thier gender is \(currentUserGender ?? "unknown").")
        }
    }
    
    private var profilePicture: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
    }
    
    private var profileView: some View {
        VStack {
            Spacer()
            VStack {
                profilePicture
                Divider()
                userInformation
                Divider()
                signOutButton
            }
            .font(.title.bold())
            .foregroundColor(textColor)
            .padding()
            .padding(.vertical, 40)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            Spacer()
            Spacer()
        }
    }
    
}

// MARK: - Previews

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
