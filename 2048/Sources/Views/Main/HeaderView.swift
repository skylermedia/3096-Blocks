//
//  HeaderView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct HeaderView: View {

    // MARK: - Properties
    
    @State private var showResetWarning: Bool = false
    @State private var highScore = UserDefaults.standard.integer(forKey: "highScore")
    @State private var showAboutSheet = false

    var proxy: GeometryProxy
    @Binding var showSideMenu: Bool
    var title: String
    @Binding var score: Int
    @Binding var scoreMultiplier: Int
    var newGameAction: () -> Void
    var showResetButton: () -> Bool
    let buttonSize: CGFloat = 48
    let appStoreLink = "https://3096.skyler.media"
    
    // MARK: - Compited View Propeties
    
    private var scoreView: some View {
        let shouldShowReset = showResetButton()
        return VStack {
            HStack {
                Text("Score: ")
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .foregroundColor(.white)
                
                Text("\(score)")
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .foregroundColor(.white)
                    .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                    .animation(.modalSpring, value: shouldShowReset)
                    .id("Score \(self.score)")
                
                Text("x\(scoreMultiplier)")
                    .font(Font.system(.body, design: .monospaced).weight(.black))
                    .foregroundColor(.white)
                    .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
            }
            .opacity(shouldShowReset ? 1.0 : 0.0)
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
            .animation(.modalSpring, value: shouldShowReset)
            .id("Score View: \(showResetButton())")
            HStack {
                Text("Best (Beta): ")
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .foregroundColor(.white)
                
                Text("\(highScore)")
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .foregroundColor(.white)
                    .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                    .animation(.modalSpring, value: shouldShowReset)
                    .id("Score \(self.score)")
            }
            .opacity(shouldShowReset ? 1.0 : 0.0)
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
            .animation(.modalSpring, value: shouldShowReset)
            .id("High Score View: \(showResetButton())")
        }
        .sheet(isPresented: $showAboutSheet) {
            AboutView()
        }
    }
    
    private var sideMenuButton: some View {
        Button(action: {
            withAnimation(.modalSpring) {
                showSideMenu.toggle()
            }
        }) {
            Image(systemName: "scribble")
                .resizable()
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: buttonSize, height: buttonSize)
                .foregroundColor(Color("signaturePink"))
        }
        .foregroundColor(.gray)
        .padding()
    }
    
    private var shareButton: some View {
        Button(action: {
            let shareSheet = UIActivityViewController(activityItems: [self.appStoreLink], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(shareSheet, animated: true, completion: nil)
        }){
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: buttonSize, height: buttonSize)
                .foregroundColor(Color("signaturePink"))
        }
        .foregroundColor(.gray)
        .padding()
    }
    
    private var resetGameButton: some View {
        Button(action: {
            withAnimation(.spring()) {
                showResetWarning.toggle()
                newGameAction()
            }
        }) {
            Image(systemName: "arrow.clockwise")
                .resizable()
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: buttonSize, height: buttonSize)
                .foregroundColor(Color("signaturePink"))
        }
        .foregroundColor(.gray)
        .padding()
        .opacity(showResetButton() ? 1.0 : 0.0)
    }
    
    private var aboutButton: some View {
        Button(action: {
            self.showAboutSheet = true
        }) {
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: buttonSize, height: buttonSize)
                .foregroundColor(Color("signaturePink"))
        }
        .foregroundColor(.gray)
        .padding()
    }
    
    private var titleView: some View {
        Text(title)
            .padding(.top, 50)
            .font(Font.system(size: 64).weight(.black))
            .foregroundColor(Color("signatureBlue"))
//            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
//            .animation(.modalSpring, value: showSideMenu)
            .id(title)
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                sideMenuButton
                Spacer()
                resetGameButton
                Spacer()
                shareButton
                Spacer()
                aboutButton
                Spacer()
            }
            .padding(.top, proxy.size.width > proxy.size.height ? 24 : 48)
            
            scoreView
        }
    }
}
