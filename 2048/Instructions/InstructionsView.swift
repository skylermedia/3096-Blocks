//
//  InstructionsView.swift
//  Weather Merge
//
//  Created by Skyler Szijjarto on 2/27/23.
//

import SwiftUI

struct InstructionsView: View {
    
    // MARK: - Instructions
    
    @State private var showInstructionsTwo: Bool = false
    @State private var showInstructionsThree : Bool = false
    
    @State private var instructionsTitle1: String = "Board"
    @State private var instructionsTitle2: String = "Game"
    @State private var instructionsTitle3: String = "Controls"
    @State private var instructionsTitle4: String = "Merging"
    @State private var instructionsTitle5: String = "Value"
    @State private var instructionsTitle6: String = "Winning"
    @State private var instructionsTitle7: String = "Losing"
    @State private var instructionsTitle8: String = "Score"
    @State private var instructionsTitle9: String = "Restarting"
    @State private var instructionsTitle10: String = "Sharing"
    
    @State private var instructions1: String = "You can choose the board size, but the default is 4x4. Each tile will display a weather symbol like a cloud, thunderstorm, or tornado."
    @State private var instructions2: String = "The objective of Weather Merge is to merge identical weather symbols to create higher-value symbols. You can easily understand the value of any tile with the number in the bottom-right corner."
    @State private var instructions3: String = "Swipe left, right, up, and down to move the weather symbols in the corresponding direction. When you move, all the tiles on the board will shift in that direction."
    @State private var instructions4: String = "If two identical weather symbols collide, they will merge into a higher-value tile. For example, if you combine two leaf symbols, they will become a single tornado symbol."
    @State private var instructions5: String = "Each time you merge two symbols, the value of the resulting symbol will be twice the value of the originals."
    @State private var instructions6: String = "There is currently no way to win Weather Merge."
    @State private var instructions7: String = "You lose when there are no possible moves."
    @State private var instructions8: String = "Your score is the total value of all the tiles. Each time you merge two symbols, the value of the resulting symbol will be added to your score."
    @State private var instructions9: String = "If you want to reset the game, click the circular arrow button at the top of your screen. It will remove all of your tiles and set your score to zero."
    @State private var instructions10: String = "If you enjoy the game, you can share it with your friends on social media by clicking the share button."
    
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
        .sheet(isPresented: $showInstructionsTwo) {
            VStack {
                Text("Gameplay")
                    .padding(.top)
                    .font(.largeTitle.bold())
                Spacer()
                instructionsText(title: instructionsTitle4, text: instructions4)
                instructionsText(title: instructionsTitle5, text: instructions5)
                instructionsText(title: instructionsTitle6, text: instructions6)
                Spacer()
                HStack {
                    Button(action: {
                        self.showInstructionsTwo = false
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                    }
                    .padding()
                    Spacer()
                    Button(action: {
                        self.showInstructionsTwo = false
                        self.showInstructionsThree = true
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showInstructionsThree) {
            VStack {
                Text("Gameplay 2")
                    .padding(.top)
                    .font(.largeTitle.bold())
                Spacer()
                instructionsText(title: instructionsTitle7, text: instructions7)
                instructionsText(title: instructionsTitle8, text: instructions8)
                instructionsText(title: instructionsTitle9, text: instructions9)
                Spacer()
                HStack {
                    Button(action: {
                        self.showInstructionsTwo = true
                        self.showInstructionsThree = false
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                    }
                    .padding()
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func iconHeader(padding spacing: CGFloat, proxy: GeometryProxy) -> some View {
        VStack {
            Text("The Basics")
                .padding(.top)
                .font(.largeTitle.bold())
            Spacer()
            instructionsText(title: instructionsTitle1, text: instructions1)
            instructionsText(title: instructionsTitle2, text: instructions2)
            instructionsText(title: instructionsTitle3, text: instructions3)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.showInstructionsTwo = true
                }) {
                    Image(systemName: "chevron.right")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)
                }
            }
        }
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
        ScrollView {
            
            VStack {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(Font.system(.title, design: .monospaced).weight(.bold))
                    .foregroundColor(.primary)
                Text(text)
                    .multilineTextAlignment(.center)
                    .font(Font.system(.callout, design: .monospaced).weight(.bold))
                    .foregroundColor(.primary)
            }
            .padding(.bottom)
            .padding([.leading, .trailing], 24)
        }
    }
}
