//
//  InstructionsView.swift
//  Weather Merge
//
//  Created by Skyler Szijjarto on 2/27/23.
//

import SwiftUI

struct InstructionsView: View {
    
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
                Text(about[PlistConfigurationKeyPath.about.rawValue]?[PlistConfigurationKeyPath.copyright.rawValue] ?? "Missing Information")
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
            
            Text("")
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .font(Font.system(.callout, design: .monospaced).weight(.bold))
                .foregroundColor(.primary)
        }
        .padding(.all, spacing)
        .center(in: .local, with: proxy)
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
