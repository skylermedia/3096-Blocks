//
//  TileView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct TileView: View {
    
    // MARK: - Properties
    
    @Environment(\.tileColorTheme) private var tileColorTheme: TileColorTheme
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @State private var gameMode = UserDefaults.standard.string(forKey: "gameMode")
    
    private var backgroundColor: Color {
        colorScheme == .light ? Color(red:0.78, green:0.73, blue:0.68, opacity: 1.0) : Color(red:0.58, green:0.53, blue:0.48, opacity: 1.0)
    }
    
    private let number: Int?
    private let textId: String
    private let fontProportionalWidth: CGFloat = 3
    
    // MARK: - Initialziers
    
    init(number: Int) {
        self.number = number
        textId = "\(number)"
    }
    
    private init() {
        number = nil
        textId = ""
    }
    
    // MARK: - Static Methods
    
    static func empty() -> Self {
        return self.init()
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        let tileColorTheme = self.tileColorTheme.colorPair(for: number, colorScheme, defaultColor: self.backgroundColor)
        
        return GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .fill(tileColorTheme.background)
                if gameMode == "letter" {
                    Text(titleLetter())
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .id(number)
                        .foregroundColor(tileColorTheme.font)
                        .transition(AnyTransition.scale(scale: 0.2).combined(with: .opacity).animation(.modalSpring(duration: 0.3)))
                } else {
                    Text(titleNumber())
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .id(number)
//                        .foregroundColor(tileColorTheme.font)
                        .transition(AnyTransition.scale(scale: 0.2).combined(with: .opacity).animation(.modalSpring(duration: 0.3)))
                }
                if number == 3 {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.yellow)
                } else if number == 4 {
                    Image(systemName: "flame.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.orange)
                } else if number == 5 {
                    Image(systemName: "cloud.rain.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                } else if number == 6 {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.yellow)
                } else if number == 7 {
                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                } else if number == 8 {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.green)
                } else if number == 9 {
                    Image(systemName: "tornado")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.red)
                } else if number == 10 {
                    Image(systemName: "umbrella.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                } else if number == 11 {
                    Image(systemName: "cloud.heavyrain.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                } else if number == 12 {
                    Image(systemName: "sunrise.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.yellow)
                } else if number == 13 {
                    Image(systemName: "cloud.sun.fill")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.yellow)
                } else if number == 14 {
                    Image(systemName: "wind")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.yellow)
                } else if number == 15 {
                    Image(systemName: "snowflake")
                        .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                        .foregroundColor(.yellow)
                }
            }
            .zIndex(Double.greatestFiniteMagnitude)
            .clipped()
            .cornerRadius(proxy.size.width / 9)
        }
    }
    
    // MARK: - Methods
    
        private func titleNumber() -> String {
            guard let number = self.number else {
                return ""
            }
            let letterDictionary = [3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: "", 16: "", 17: "", 18: "", 19: "" ]
            let letter = letterDictionary[number]
            return letter ?? "!"
        }
        private func titleLetter() -> String {
            guard let number = self.number else {
                return ""
            }
            let letterDictionary = [3: "a", 4: "b", 5: "c", 6: "d", 7: "e", 8: "f", 9: "g", 10: "h", 11: "i", 12: "j", 13: "k", 14: "l", 15: "m", 16: "n", 17: "o", 18: "p", 19: "q", 20: "r", 21: "s", 22: "t", 23: "u", 24: "v", 25: "w", 26: "x", 27: "y", 28: "z", 29: "A", 30: "B", 31: "C", 32: "D", 33: "E", 34: "F", 35: "G", 36: "J", 37: "I", 38: "J", 39: "K", 40: "L", 41: "M", 42: "N", 43: "O", 44: "P", 45: "Q", 46: "R", 47: "S", 48: "T", 49: "U", 50: "V", 51: "W", 52: "X", 53: "Y", 54: "Z", 55: "aa", 56: "bb", 57: "cc", 58: "dd", 59: "ee", 60: "ff", 61: "gg", 62: "hh", 63: "ii"]
            let letter = letterDictionary[number]
            return letter ?? "!"
        }
    private func fontSize(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.width / fontProportionalWidth
    }
}
