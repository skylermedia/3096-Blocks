//
//  BetaLoginView.swift
//  Merge
//
//  Created by Skyler Szijjarto on 3/4/23.
//

import SwiftUI

struct BetaLoginView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            
            
            if currentUserSignedIn {
                ProfileView()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                    .padding()
            } else {
                ZStack {
                    RadialGradient(gradient: Gradient(colors: [.purple.opacity(0.8), .blue]),
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

struct BetaLoginView_Previews: PreviewProvider {
    static var previews: some View {
        BetaLoginView()
    }
}
