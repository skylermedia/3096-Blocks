//
//  HeaderView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct HeaderView: View {

    // MARK: - Properties
    
    @State private var showResetWarning: Bool = false
    @State private var showAboutSheet = false
    @State var showInstructionsSheet = false

    var proxy: GeometryProxy
    @Binding var showSideMenu: Bool
    var title: String
    @Binding var score: Int
    @Binding var scoreMultiplier: Int
    @Binding var highScore: Int
    @AppStorage("scoreGoal") var scoreGoal: Int = 100
    @AppStorage("level") var level: Int = 0
    var newGameAction: () -> Void
    var showResetButton: () -> Bool
    let buttonSize: CGFloat = 48
    let appStoreLink = "https://merge.skyler.media"
    
    // MARK: - Compited View Propeties
    
    private var scoreView: some View {
        let shouldShowReset = showResetButton()
        return VStack {
            HStack {
                Text("Goal: ")
                    .font(shouldShowReset ? Font.system(.title, design: .monospaced).weight(.black) : Font.caption2)
                    .foregroundColor(Color(red:0.49, green:0.49, blue:0.49, opacity: 0.7))

                Text("\(scoreGoal)")
                    .font(shouldShowReset ? Font.system(.title, design: .monospaced).weight(.black) : Font.caption2)
                    .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
                    .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                    .animation(.modalSpring, value: shouldShowReset)
                    .id("Score Goal \(self.scoreGoal)")
                Text("\(level)")
                    .font(Font.system(.body, design: .monospaced).weight(.black))
                    .foregroundColor(Color.primary.opacity(0.7))
                    .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
            }
            .opacity(shouldShowReset ? 1.0 : 0.0)
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
            .animation(.modalSpring, value: shouldShowReset)
            .id("Score Goal View: \(showResetButton())")
            HStack {
                Text("Score: ")
                    .font(shouldShowReset ? Font.system(.title, design: .monospaced).weight(.black) : Font.caption2)
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
                    .font(shouldShowReset ? Font.system(.title, design: .monospaced).weight(.black) : Font.caption2)
                    .foregroundColor(Color(red:0.49, green:0.49, blue:0.49, opacity: 0.7))

                Text("\(highScore)")
                    .font(shouldShowReset ? Font.system(.title, design: .monospaced).weight(.black) : Font.caption2)
                    .foregroundColor(Color(red:0.59, green:0.59, blue:0.59, opacity: 1.00))
                    .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                    .animation(.modalSpring, value: shouldShowReset)
                    .id("High Score \(self.highScore)")
            }
            .opacity(shouldShowReset ? 1.0 : 0.0)
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
            .animation(.modalSpring, value: shouldShowReset)
            .id("High Score View: \(showResetButton())")
        }
        .sheet(isPresented: $showAboutSheet) {
            AboutView()
        }
        .sheet(isPresented: $showInstructionsSheet) {
            InstructionsView()
        }
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
                .foregroundColor(.gray)
        }
        .foregroundColor(.gray)
        .padding()
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
    
    private var shareButton: some View {
        ShareButton(appStoreLink: appStoreLink, buttonSize: buttonSize)
//        Button(action: {
//            let shareSheet = UIActivityViewController(activityItems: [self.appStoreLink], applicationActivities: nil)
//            UIApplication.shared.windows.first?.rootViewController?.present(shareSheet, animated: true, completion: nil)
//        }){
//            Image(systemName: "square.and.arrow.up")
//                .resizable()
//                .scaledToFit()
//                .aspectRatio(1, contentMode: .fit)
//                .frame(width: buttonSize, height: buttonSize)
//                .foregroundColor(.gray)
//        }
        .foregroundColor(.gray)
        .padding()
        .opacity(showResetButton() ? 1.0 : 0.0)
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
    
    private var instructionsButton: some View {
        Button(action: {
            self.showInstructionsSheet = true
            UserDefaults.standard.set(showInstructionsSheet, forKey: "showInstructionsSheet")
        }) {
            Image(systemName: "book")
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
            .fontWeight(.heavy)
            .font(.largeTitle)
            .opacity(!showResetButton() ? 1.0 : 0.0)
            .padding(.top, proxy.size.width > proxy.size.height ? -10 : -20)
            .transition(AnyTransition.move(edge: .trailing).combined(with: .opacity))
            .id(title)
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        ZStack {
            titleView
            VStack {
                HStack {
                    Spacer()
                    sideMenuButton
                    Spacer()
                    resetGameButton
                    Spacer()
                    shareButton
                    Spacer()
                    instructionsButton
                    Spacer()
                }
                .padding(.top, proxy.size.width > proxy.size.height ? 24 : 48)
                Divider()
                    .padding(.horizontal)
                
                scoreView
            }
        }
    }
}

private struct ShareButton: View {
    @State private var shareSheet: UIActivityViewController?
    
    private let appStoreLink: String
    private let buttonSize: CGFloat
    
    init(appStoreLink: String, buttonSize: CGFloat) {
        self.appStoreLink = appStoreLink
        self.buttonSize = buttonSize
    }
    
    var body: some View {
        Button(action: {
            if let shareSheet = shareSheet {
                // If the share sheet is already created, reuse it.
                UIApplication.shared.topViewController?.present(shareSheet, animated: true, completion: nil)
            } else {
                // Otherwise, create a new share sheet.
                let shareSheet = UIActivityViewController(activityItems: [self.appStoreLink], applicationActivities: nil)
                UIApplication.shared.topViewController?.present(shareSheet, animated: true, completion: nil)
                self.shareSheet = shareSheet
            }
        }) {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: buttonSize, height: buttonSize)
                .foregroundColor(.gray)
        }
        .foregroundColor(.gray)
    }
}

extension UIApplication {
    var topViewController: UIViewController? {
        return windows.first?.rootViewController
    }
}

extension UIViewController {
    var topViewController: UIViewController {
        if let presentedViewController = presentedViewController {
            return presentedViewController
        }
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController ?? self
        }
        if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController ?? self
        }
        return self
    }
}
