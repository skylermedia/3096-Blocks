//
//  AboutView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct AboutView: View {
    
    // MARK: - Properties
    
    private let plist = PlistConfiguration(name: "Strings")
    private let about: [String : [String : String]]
    
    // MARK: - Initializers
    
    init() {
        about = plist?.getItem(named: PlistConfigurationKeyPath.about.rawValue) ?? ["" : [:]]
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        GeometryReader { proxy in
            iconHeader(padding: UIDevice.current.userInterfaceIdiom == .pad ? 64 : 32, proxy: proxy)
            
            HStack {
                Text(about[PlistConfigurationKeyPath.about.rawValue]?[PlistConfigurationKeyPath.copyright.rawValue] ?? "[Missing Information]")
                    .font(Font.system(.callout, design: .monospaced).weight(.bold))
                    .foregroundColor(.secondary)
            }
            .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).maxY)
            
        }
        .padding(.bottom, 24)
        .padding([.leading, .trailing], 48)
    }

    // MARK: - Private Methods

    private func iconHeader(padding spacing: CGFloat, proxy: GeometryProxy) -> some View {
        VStack(spacing: 8) {
            Image("Icon")
                .resizable()
                .cornerRadius(25)
                .aspectRatio(contentMode: .fit)
            if #available(iOS 16.0, *) {
                Text(about[PlistConfigurationKeyPath.about.rawValue]?[PlistConfigurationKeyPath.linkDescription.rawValue] ?? "[Missing Information]")
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .font(Font.system(.callout, design: .monospaced).weight(.bold))
                .foregroundColor(.primary)
            } else {
                // Fallback on earlier versions
            }
        }
        .padding(.all, spacing)
        .center(in: .local, with: proxy)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
