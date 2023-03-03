//
//  InstructionsView.swift
//  Weather Merge
//
//  Created by Skyler Szijjarto on 2/27/23.
//

import SwiftUI

struct InstructionsView: View {
    
    // MARK: - Instructions
    
    @State private var showInstructionsOne: Bool = false
    @State private var instructions4: String = "4. Merging: If two identical weather symbols collide, they will merge into a higher-value tile. For example, if you combine two leaf symbols, they will become a single tornado symbol."
    @State private var instructions5: String = "5. Value: Each time you merge two symbols, the value of the resulting symbol will be twice the value of the originals."
    @State private var instructions6: String = "6. Winning: There is currently no way to win Weather Merge."
    @State private var instructions7: String = "7. Losing: You lose when there are no possible moves."
    @State private var instructions8: String = "8. Score: Your score is the total value of all the tiles. Each time you merge two symbols, the value of the resulting symbol will be added to your score."
    @State private var instructions9: String = "9. Restarting: If you want to reset the game, click the circular arrow button at the top of your screen. It will remove all of your tiles and set your score to zero."
    @State private var instructions10: String = "10. Sharing: If you enjoy the game, you can share it with your friends on social media by clicking the share button."
    
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
            iconHeader(padding: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 16, proxy: proxy)
        }
        .padding([.leading, .trailing], 24)
    }
    
    // MARK: - Private Methods
    
    private func iconHeader(padding spacing: CGFloat, proxy: GeometryProxy) -> some View {
        VStack(spacing: 8) {

//            instructionsText(title: instructionsTitle1, text: instructions4)
//            instructionsText(title: instructionsTitle1, text: instructions5)
//            instructionsText(title: instructionsTitle1, text: instructions6)
//            instructionsText(title: instructionsTitle1, text: instructions7)
//            instructionsText(title: instructionsTitle1, text: instructions8)
//            instructionsText(title: instructionsTitle1, text: instructions9)
//            instructionsText(title: instructionsTitle1, text: instructions10)
            Button(action: {
                self.showInstructionsOne = true
            }) {
                Text("Button")
            }
                .padding(.all, spacing)
                .center(in: .local, with: proxy)
        }
//        .sheet(isPresented: $showInstructionsOne) {
//            instructionsViewOne()
//        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}

struct instructionsText: View {
    
    let title: String
    let text: String
    
    var body: some View {
        Text(title)
            .multilineTextAlignment(.leading)
            .font(Font.system(.title, design: .monospaced).weight(.bold))
            .foregroundColor(.primary)
        Text(text)
            .multilineTextAlignment(.leading)
            .font(Font.system(.callout, design: .monospaced).weight(.bold))
            .foregroundColor(.primary)
    }
}

struct instructionsViewOne {
    @State private var instructionsTitle1: String = "Board"
    @State private var instructions1: String = "1. You can choose the board size, but the default is 4x4. Each tile will display a weather symbol like a cloud, thunderstorm, or tornado."
    @State private var instructions2: String = "2. Game: The objective of Weather Merge is to merge identical weather symbols to create higher-value symbols. You can easily understand the value of any tile with the number in the bottom-right corner."
    @State private var instructions3: String = "3. Controls: Swipe left, right, up, and down to move the weather symbols in the corresponding direction. When you move, all the tiles on the board will shift in that direction."
    
    var body: some View {
        VStack {
            instructionsText(title: instructionsTitle1, text: instructions1)
            instructionsText(title: instructionsTitle1, text: instructions2)
            instructionsText(title: instructionsTitle1, text: instructions3)
        }
    }
}
