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
    
    var proxy: GeometryProxy
    @Binding var showSideMenu: Bool
    var title: String
    @Binding var score: Int
    @Binding var scoreMultiplier: Int
    var newGameAction: () -> Void
    var showResetButton: () -> Bool
    @AppStorage("highScore") private var highScore: Int = 0
    let buttonSize: CGFloat = 48
    
    // MARK: - Compited View Propeties
    
    private var scoreView: some View {
        let shouldShowReset = showResetButton()
        return VStack {
            HStack {
                Text("Score: ")
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .foregroundColor(Color(red:0.49, green:0.49, blue:0.49, opacity: 0.7))
                
                Text("\(score)")
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
                    .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                    .animation(.modalSpring, value: shouldShowReset)
                    .id("Score \(self.score)")
                
                Text("x\(scoreMultiplier)")
                    .font(Font.system(.body, design: .monospaced).weight(.black))
                    .foregroundColor(Color.primary.opacity(0.7))
                    .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
            }
            .opacity(shouldShowReset ? 1.0 : 0.0)
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
            .animation(.modalSpring, value: shouldShowReset)
            .id("Score View: \(showResetButton())")
            HStack {
                Text("High Score: ")
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .foregroundColor(Color(red:0.49, green:0.49, blue:0.49, opacity: 0.7))
                
                Text("\(highScore)")
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
                    .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                    .animation(.modalSpring, value: shouldShowReset)
                    .id("Score \(self.score)")
            }
            .opacity(shouldShowReset ? 1.0 : 0.0)
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
            .animation(.modalSpring, value: shouldShowReset)
            .id("High Score View: \(showResetButton())")
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
                .foregroundColor(.gray)
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
                .foregroundColor(.gray)
        }
        .foregroundColor(.gray)
        .padding()
        .opacity(showResetButton() ? 1.0 : 0.0)
    }
    
    private var titleView: some View {
        Text(title)
            .font(Font.system(size: 46).weight(.black))
            .foregroundColor(Color(red:0.29, green:0.29, blue:0.29, opacity: 1.00))
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
            .animation(.modalSpring, value: showSideMenu)
            .id(title)
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        VStack {
            HStack {
                sideMenuButton
                Spacer()
                titleView
                Spacer()
                resetGameButton
            }
            .padding(.top, proxy.size.width > proxy.size.height ? 24 : 48)
            
            scoreView
        }
    }
}
