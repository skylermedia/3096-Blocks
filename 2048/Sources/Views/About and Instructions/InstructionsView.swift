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
        }
        .padding([.leading, .trailing], 24)
    }

    // MARK: - Private Methods

    private func iconHeader(padding spacing: CGFloat, proxy: GeometryProxy) -> some View {
        VStack(spacing: 8) {
            if #available(iOS 16.0, *) {
                Text("Instructions Will be Here Soon")
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .font(Font.system(.callout, design: .monospaced).weight(.bold))
                    .foregroundColor(.primary)
            } else {
                Text("Instructions Will be Here Soon")
                    .multilineTextAlignment(.center)
                    .font(Font.system(.callout, design: .monospaced).weight(.bold))
                    .foregroundColor(.primary)
            }
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
