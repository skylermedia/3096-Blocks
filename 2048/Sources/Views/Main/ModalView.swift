//
//  ModalView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct ModalView: View {
    
    // MARK: - Environment Properties
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.colorSchemeBackgroundTheme) private var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme
   
    // MARK: - Properties
    
    @State private var resetWithScore = false
    @Binding var score: Int
    @Binding var highScore: Int
    @Binding var scoreGoal: Int
    @Binding var level: Int
    
    var title: String
    var subtitle: String? = nil
    var completionHandler: () -> Void
    var cancellationHandler: (() -> Void)?
    
    // MARK: - Conformane to View Protocol
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 16) {
                header
                subheader
                cancellationHandlerView
            }
            .padding()
            .background(Rectangle().fill(colorSchemeBackgroundTheme.backgroundColor(for: colorScheme)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.primary.opacity(0.3), radius: 20)
            .alignmentGuide(VerticalAlignment.center) {
                $0[VerticalAlignment.bottom] + 24
            }
            .frame(maxWidth: proxy.size.width / 1.2)
            .center(in: .local, with: proxy)
        }
    }
    
    private var header: some View {
        Text(title)
            .font(.system(.largeTitle, design: .monospaced))
            .bold()
            .foregroundColor(.primary)
            .animation(.modalSpring)
    }
    
    @ViewBuilder private var subheader: some View {
        if subtitle != nil {
            Text(subtitle!) // safe to unwrap
                .font(Font.system(.body, design: .monospaced).weight(.bold))
                .foregroundColor(.secondary)
                .animation(.modalSpring)
        }
    }
    
    @ViewBuilder private var cancellationHandlerView: some View {
        if cancellationHandler == nil {
            newGameBody
        } else {
            cancelBody
        }
    }
    
    private var cancelBody: some View {
        HStack(spacing: 32) {
            Button(action: cancelGameAction) {
                Text("Confirm")
                    .foregroundColor(colorSchemeBackgroundTheme.backgroundColor(for: colorScheme))
                    .font(.system(.body, design: .monospaced))
                    .bold()
                    .zIndex(Double.greatestFiniteMagnitude)
            }
            .buttonStyle(FilledBackgroundStyle())
            .padding([.top, .bottom, .trailing])
            
            Button(action: cancellationHandler!) { // safe to unwrap
                Text("Cancel")
                    .foregroundColor(colorSchemeBackgroundTheme.backgroundColor(for: colorScheme))
                    .font(.system(.body, design: .monospaced))
                    .bold()
                    .zIndex(Double.greatestFiniteMagnitude)
            }
            .buttonStyle(FilledBackgroundStyle())
            .padding([.top, .leading, .bottom])
        }
    }
    
    private var newGameBody: some View {
        VStack {
            Button(action: newGameAction) {
                Text("New Game")
                    .foregroundColor(colorSchemeBackgroundTheme.backgroundColor(for: colorScheme))
                    .font(.system(.body, design: .monospaced))
                    .bold()
                    .zIndex(Double.greatestFiniteMagnitude)
            }
            .buttonStyle(FilledBackgroundStyle())
            .padding(.horizontal)
            Button(action: resetWithScoreAction) {
                Text("Reset With Score (Beta)")
                    .foregroundColor(colorSchemeBackgroundTheme.backgroundColor(for: colorScheme))
                    .font(.system(.body, design: .monospaced))
                    .bold()
                    .zIndex(Double.greatestFiniteMagnitude)
            }
            .buttonStyle(FilledBackgroundStyle())
            .padding(.horizontal)
        }
    }
    
    func allGameAction() {
        completionHandler()
        UserDefaults.standard.set(resetWithScore, forKey: "resetWithScore")
    }
    
    func cancelGameAction() {
        print("User: Reset game manualy")
        score = 0
        _ = false
        allGameAction()
    }
    
    func newGameAction() {
        print("User: Reset without score")
        score = 0
        _ = false
        allGameAction()
    }
    
    func resetWithScoreAction() {
        print("User: Reset with score")
        _ = true
        allGameAction()
    }
}
