//
//  BetaLoginView.swift
//  Merge
//
//  Created by Skyler Szijjarto on 3/4/23.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Environment
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    // MARK: - App Storage
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    // MARK: - Colors
    
    private var gradientColor1: Color {
        colorScheme == .light ? .purple : .blue.opacity(0.75)
    }
    
    private var gradientColor2: Color {
        colorScheme == .light ? .blue : .purple.opacity(0.75)
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        ZStack {
            if currentUserSignedIn {
                ProfileView()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                    .padding()
            } else {
                ZStack {
                    RadialGradient(gradient: Gradient(colors: [gradientColor1.opacity(0.8), gradientColor2]),
                                   center: .topLeading,
                                   startRadius: 5,
                                   endRadius: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                }
                OnboardingView()
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                
            }
        }
    }
}

// MARK: - Previews

struct BetaLoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
