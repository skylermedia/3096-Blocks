//
//  SideMenuView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct SideMenuView: View {
    
    // MARK: - Environment Properties
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.colorSchemeBackgroundTheme) private var colorSchemeBackgroundTheme: ColorSchemeBackgroundTheme

    // MARK: - Properties
    
    @Binding var selectedView: SelectedView
    @State private var userName: String = (UserDefaults.standard.string(forKey: "userName") ?? "username")

    var onMenuChangeHandler: () -> Void
    
    var adminItems: [SelectedView] = [ .game, .levels, .ranks, .settings, .about, .stats, .multiplayer ]
    var items: [SelectedView] = [ .game, .levels, .ranks, .settings, .about ]
    
    // MARK: - Constants
    
    let interItemSpacing: CGFloat = 44
    let cornerRadius: CGFloat = 25
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        GeometryReader { proxy in
            Group {
                VStack(spacing: interItemSpacing) {
                    Spacer()
                    if userName == "Skyler.Admin" {
                        ForEach(0..<adminItems.count, id: \.self) { adminItem in
                            self.adminItem(named: adminItems[adminItem].title) {
                                selectedView = adminItems[adminItem]
                                onMenuChangeHandler()
                            }
                        }
                    } else {
                        ForEach(0..<items.count, id: \.self) { item in
                            self.item(named: items[item].title) {
                                selectedView = items[item]
                                onMenuChangeHandler()
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                .padding([.leading, .trailing])
                .padding(.leading, proxy.size.width > proxy.size.height ? 32 : (horizontalSizeClass == .regular ? 16 : 4) )
            }
            .background(Rectangle().fill(colorSchemeBackgroundTheme.backgroundColor(for: colorScheme)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.primary.opacity(0.3), radius: 20)
            .alignmentGuide(HorizontalAlignment.center) {
                $0[HorizontalAlignment.leading]
            }
            .frame(height: proxy.size.height / 1.15)
            .center(in: .local, with: proxy)
        }
    }
    
    // MARK: - Private Methods
    
    private func item(named name: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(name)
                .font(.system(.title, design: .monospaced))
                .bold()
                .foregroundColor(.primary)
                .animation(.modalSpring)
                .shadow(
                    color: colorSchemeBackgroundTheme.invertedBackgroundColor(for: colorScheme),
                    radius: cornerRadius
                )
        }.eraseToAnyView
    }
    
    private func adminItem(named name: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(name)
                .font(.system(.title, design: .monospaced))
                .bold()
                .foregroundColor(.primary)
                .animation(.modalSpring)
                .shadow(
                    color: colorSchemeBackgroundTheme.invertedBackgroundColor(for: colorScheme),
                    radius: cornerRadius
                )
        }.eraseToAnyView
    }
}
