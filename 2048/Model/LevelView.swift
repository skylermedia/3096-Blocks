//
//  LevelView.swift
//  Merge
//
//  Created by Skyler Szijjarto on 2/28/23.
//

import SwiftUI

struct LevelView: View {
    
    // MARK: - App Storage
    
    @AppStorage("scoreGoal") var scoreGoal: Int?
    
    // MARK: - Properties
    
    @State private var level: Int? = 0
    @State private var showRestartPrompt: Bool = false
    @State private var showResetPrompt: Bool = false
    @State private var resetNextMove: Bool = false
    
    // MARK: - Levels
    
    @AppStorage("isLevelUnlocked0") var isLevelUnlocked0: Bool = true
    @AppStorage("isLevelUnlocked1") var isLevelUnlocked1: Bool = true
    @AppStorage("isLevelUnlocked2") var isLevelUnlocked2: Bool = false
    @AppStorage("isLevelUnlocked3") var isLevelUnlocked3: Bool = false
    @AppStorage("isLevelUnlocked4") var isLevelUnlocked4: Bool = false
    @AppStorage("isLevelUnlocked5") var isLevelUnlocked5: Bool = false
    @AppStorage("isLevelUnlocked6") var isLevelUnlocked6: Bool = false
    @AppStorage("isLevelUnlocked7") var isLevelUnlocked7: Bool = false
    @AppStorage("isLevelUnlocked8") var isLevelUnlocked8: Bool = false
    @AppStorage("isLevelUnlocked9") var isLevelUnlocked9: Bool = false
    @AppStorage("isLevelUnlocked10") var isLevelUnlocked10: Bool = false
    @AppStorage("isLevelUnlocked11") var isLevelUnlocked11: Bool = false
    @AppStorage("isLevelUnlocked12") var isLevelUnlocked12: Bool = false
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        VStack(spacing: 0) {
            resetText
            mainGridView
                .edgesIgnoringSafeArea(.all)
        }
    }
}

// MARK: - Grid

extension LevelView {
    
    private var mainGridView: some View {
        VStack(spacing: 0) {
            row1
            row2
            row3
            row4
        }
    }
    
    private var resetText: some View {
        Text("Your game will be reset if you manually change your level.")
            .font(.body.bold())
            .multilineTextAlignment(.center)
            .padding(.horizontal, 25)
    }
    
}

// MARK: - Rows

extension LevelView {
    
    private var row0: some View {
        LevelButton(level: 0, isLevelUnlocked: isLevelUnlocked0)
    }

    private var row1: some View {
        HStack(spacing: 0) {
            LevelButton(level: 1, isLevelUnlocked: isLevelUnlocked1)
            LevelButton(level: 2, isLevelUnlocked: isLevelUnlocked2)
            LevelButton(level: 3, isLevelUnlocked: isLevelUnlocked3)
        }
    }
    
    private var row2: some View {
        HStack(spacing: 0) {
            LevelButton(level: 4, isLevelUnlocked: isLevelUnlocked4)
            LevelButton(level: 5, isLevelUnlocked: isLevelUnlocked5)
            LevelButton(level: 6, isLevelUnlocked: isLevelUnlocked6)
        }
    }
    
    private var row3: some View {
        HStack(spacing: 0) {
            LevelButton(level: 7, isLevelUnlocked: isLevelUnlocked7)
            LevelButton(level: 8, isLevelUnlocked: isLevelUnlocked8)
            LevelButton(level: 9, isLevelUnlocked: isLevelUnlocked9)
        }
    }
    
    private var row4: some View {
        HStack(spacing: 0) {
            LevelButton(level: 10, isLevelUnlocked: isLevelUnlocked10)
            LevelButton(level: 11, isLevelUnlocked: isLevelUnlocked11)
            LevelButton(level: 12, isLevelUnlocked: isLevelUnlocked12)
        }
    }
    
}

// MARK: - Buttons

struct LevelButton: View {
    
    // MARK: - App Storage
    
    @AppStorage("scoreGoal") var scoreGoal: Int?
    
    // MARK: - Properties
    
    @State var level: Int
    @State var isLevelUnlocked: Bool
    
    // MARK: - Alert
    
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false

    // MARK: - Color
    
    private let buttonColor = Color.primary.opacity(0.8)
    
    // MARK: - App Storage
    
    @AppStorage("levelChanged") var levelChanged: Bool = false
    
    // MARK: - Conformance to View Protocol

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                Button(action: {
                    if isLevelUnlocked == true {
                        switch level {
                        case 0:
                            scoreGoal = 100
                        case 1:
                            scoreGoal = 1000
                        case 2:
                            scoreGoal = 25000
                        case 3:
                            scoreGoal = 50000
                        case 4:
                            scoreGoal = 75000
                        case 5:
                            scoreGoal = 100000
                        case 6:
                            scoreGoal = 150000
                        case 7:
                            scoreGoal = 250000
                        case 8:
                            scoreGoal = 500000
                        case 9:
                            scoreGoal = 1000000
                        case 10:
                            scoreGoal = 2500000
                        case 11:
                            scoreGoal = 5000000
                        case 12:
                            scoreGoal = 10000000
                        default:
                            break
                        }
                        
                        // Alert
                        showAlert(title: "Your level has been changed to \(level). Your game will be reset on your next move.")
                        
                        // Haptics
                        Haptic.light()
                        
                        // Store Data
                        UserDefaults.standard.set(scoreGoal, forKey: "scoreGoal")
                        levelChanged = true
                        UserDefaults.standard.set(level, forKey: "level")
                        print(level)
                    } else {
                        
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(buttonColor)
                            .frame(width: (geometry.size.width) / 2, height: (geometry.size.width) / 2)
                            .cornerRadius(10)
                        if isLevelUnlocked == true {
                            Text("\(level)")
                                .font(.largeTitle)
                                .foregroundColor(Color("signaturePink"))
                        } else {
                            lockedLevelButton
                        }
                    }
                    
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
}

extension LevelButton {
    
    private var lockedLevelButton: some View {
        Image(systemName: "lock.fill")
            .foregroundColor(.white)
            .font(.title)
    }
    
}

// MARK: - Previews

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
            .padding(.top)
    }
}

