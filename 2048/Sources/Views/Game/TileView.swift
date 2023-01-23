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
                
                Text(title())
                    .font(.system(size: fontSize(proxy), weight: .bold, design: .monospaced))
                    .id(number)
                    .foregroundColor(tileColorTheme.font)
                    .transition(AnyTransition.scale(scale: 0.2).combined(with: .opacity).animation(.modalSpring(duration: 0.3)))
            }
            .zIndex(Double.greatestFiniteMagnitude)
            .clipped()
            .cornerRadius(proxy.size.width / 9)
        }
    }
    
    // MARK: - Methods
    
//    private func title() -> String {
//        guard let number = self.number else {
//            return ""
//        }
//        return String(number)
//    }
    
    private func title() -> String {
        guard let number = self.number else {
            return ""
        }
        let letterDictionary = [3: "a", 4: "b", 5: "c", 6: "d", 7: "e", 8: "f", 9: "g", 10: "h", 11: "i", 12: "j", 13: "k", 14: "l", 15: "m", 16: "n", 17: "o", 18: "p", 19: "q", 20: "r", 21: "s", 22: "t", 23: "u", 24: "v", 25: "w", 26: "x", 27: "y", 28: "z", 29: "A", 30: "B", 31: "C", 32: "D", 33: "E", 34: "F", 35: "G", 36: "J", 37: "I", 38: "J", 39: "K", 40: "L", 41: "M", 42: "N", 43: "O", 44: "P", 45: "Q", 46: "R", 47: "S", 48: "T", 49: "U", 50: "V", 51: "W", 52: "X", 53: "aa", 54: "bb", 55: "cc", 56: "dd", 57: "ee", 58: "ff", 59: "gg", 60: "hh", 61: "ii", 62: "jj", 63: "kk"]
        let letter = letterDictionary[number]
        return letter ?? "!"
    }

    private func fontSize(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.width / fontProportionalWidth
    }
}
