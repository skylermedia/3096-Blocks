//
//  TileView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct TileView: View {
    
    // MARK: - Properties
    
    @Environment(\.tileColorTheme) private var tileColorTheme: TileColorTheme
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @State private var gameMode = UserDefaults.standard.string(forKey: "gameMode")
    
    @State private var showTileSheet: Bool = false
    
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
                if gameMode == "letters" {
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
                
                if gameMode == "symbols" {
                    switch number {
                    case 3:
                        TileNI(image: "bolt.fill", number: 1, color: .yellow)
                    case 4:
                        TileNI(image: "flame.fill", number: 2, color: .orange)
                    case 5:
                        TileNI(image: "cloud.rain.fill", number: 3, color: .blue)
                    case 6:
                        TileNI(image: "sun.max.fill", number: 4, color: .yellow)
                    case 7:
                        TileNI(image: "moon.stars.fill", number: 5, color: .blue)
                    case 8:
                        TileNI(image: "leaf.fill", number: 6, color: .green)
                    case 9:
                        TileNI(image: "tornado", number: 7, color: .red)
                    case 10:
                        TileNI(image: "umbrella.fill", number: 8, color: .blue)
                    case 11:
                        TileNI(image: "cloud.heavyrain.fill", number: 9, color: .blue)
                    case 12:
                        TileNI(image: "sunrise.fill", number: 10, color: .yellow)
                    case 13:
                        TileNI(image: "cloud.sun.fill", number: 11, color: .yellow)
                    case 14:
                        TileNI(image: "wind", number: 12, color: .yellow)
                    case 15:
                        TileNI(image: "snowflake", number: 13, color: .yellow)
                    case 16:
                        TileNI(image: "water.waves", number: 14, color: .blue)
                    case 17:
                        TileNI(image: "hurricane", number: 15, color: .gray)
                    case 18:
                        TileNI(image: "cloud.bolt.fill", number: 16, color: .purple)
                    case 19:
                        TileNI(image: "sparkles", number: 17, color: .red)
                    case 20:
                        TileNI(image: "smoke.fill", number: 18, color: .blue)
                    case 21:
                        TileNI(image: "cloud.sun.bolt.fill", number: 19, color: .orange)
                    case 22:
                        TileNI(image: "drop.fill", number: 20, color: .yellow)
                    case 23:
                        TileNI(image: "bolt.shield.fill", number: 21, color: .purple)
                    default:
                        Text("")
                    }
                }
            }
            .onLongPressGesture(maximumDistance: 25, perform: { tileLongPress() })
            .zIndex(Double.greatestFiniteMagnitude)
            .clipped()
            .cornerRadius(proxy.size.width / 9)
        }
        .sheet(isPresented: $showTileSheet) {
            VStack {
                HStack {
                    Spacer()
                    HStack {
                        ZStack {
                            Rectangle()
                                .fill(tileColorTheme.background)
                                .frame(width: 75, height: 75)
                                .clipped()
                                .cornerRadius(10)
                            weatherTiles
                        }
                    }
                    Spacer()
                    
                    switch number {
                    case 3:
                        Text("Lightning")
                            .font(.largeTitle.bold())
                    case 4:
                        Text("Flame")
                            .font(.largeTitle.bold())
                    case 5:
                        Text("Rain Cloud")
                            .font(.largeTitle.bold())
                    case 6:
                        Text("Sun")
                            .font(.largeTitle.bold())
                    case 7:
                        Text("Moon Stars")
                            .font(.largeTitle.bold())
                    case 8:
                        Text("Leaf")
                            .font(.largeTitle.bold())
                    case 9:
                        Text("Tornado")
                            .font(.largeTitle.bold())
                    case 10:
                        Text("Umbrella")
                            .font(.largeTitle.bold())
                    case 11:
                        Text("Heavy Rain Cloud")
                            .font(.largeTitle.bold())
                    case 12:
                        Text("Sunrise")
                            .font(.largeTitle.bold())
                    case 13:
                        Text("Sun Cloud")
                            .font(.largeTitle.bold())
                    case 14:
                        Text("Wind")
                            .font(.largeTitle.bold())
                    case 15:
                        Text("Snowflake")
                            .font(.largeTitle.bold())
                    case 16:
                        Text("Water Waves")
                            .font(.largeTitle.bold())
                    case 17:
                        Text("Hurricane")
                            .font(.largeTitle.bold())
                    case 18:
                        Text("Cloud Bolt")
                            .font(.largeTitle.bold())
                    case 19:
                        Text("Sparkles")
                            .font(.largeTitle.bold())
                    case 20:
                        Text("Smoke")
                            .font(.largeTitle.bold())
                    case 21:
                        Text("Cloud Sun Bolt")
                            .font(.largeTitle.bold())
                    case 22:
                        Text("Water Drop")
                            .font(.largeTitle.bold())
                    case 23:
                        Text("Bolt Shield")
                            .font(.largeTitle.bold())
                    case 24:
                        Text("Bag")
                            .font(.largeTitle.bold())
                    case 25:
                        Text("Cart")
                            .font(.largeTitle.bold())
                    case 26:
                        Text("Bag")
                            .font(.largeTitle.bold())
                    case 27:
                        Text("Giftcard")
                            .font(.largeTitle.bold())
                    case 28:
                        Text("Banknote")
                            .font(.largeTitle.bold())
                    case 29:
                        Text("Credit Card")
                            .font(.largeTitle.bold())
                    case 30:
                        Text("Walk")
                            .font(.largeTitle.bold())
                    case 31:
                        Text("Hitchhike")
                            .font(.largeTitle.bold())
                    case 32:
                        Text("Scooter")
                            .font(.largeTitle.bold())
                    case 33:
                        Text("Bicycle")
                            .font(.largeTitle.bold())
                    case 34:
                        Text("Car")
                            .font(.largeTitle.bold())
                    case 35:
                        Text("Electric Car")
                            .font(.largeTitle.bold())
                    case 36:
                        Text("Box Truck")
                            .font(.largeTitle.bold())
                    case 37:
                        Text("Bus")
                            .font(.largeTitle.bold())
                    case 38:
                        Text("Tram")
                            .font(.largeTitle.bold())
                    case 39:
                        Text("Airplane Departure")
                            .font(.largeTitle.bold())
                    case 40:
                        Text("Airplane")
                            .font(.largeTitle.bold())
                    case 41:
                        Text("Airplane Arrival")
                            .font(.largeTitle.bold())
                    case 42:
                        Text("Medal")
                            .font(.largeTitle.bold())
                    default:
                        Text("Blank Tile 🤯")
                            .font(.largeTitle.bold())
                        Text("Plese contact support@skyler.media if you see this.")
                            .font(.body.bold())
                    }
                    
                    Spacer()
                }
                
                Divider()
                HStack {
                    Text("Next Tile:")
                        .font(.title.bold())
                    ZStack {
                        Rectangle()
                            .fill(tileColorTheme.background)
                            .frame(width: 75, height: 75)
                            .clipped()
                            .cornerRadius(10)
                        weatherTiles
                    }
                }
                
                HStack {
                    Text("ID: " )
                        .font(.title.bold())
                    Text("\((number ?? 0) - 2)")
                        .font(.title.bold())
                }
                
                Spacer()
            }
            .padding([.top], 50)
        }
    }
}

// MARK: - Weather Tiles

extension TileView {
    
    private var weatherTiles: some View {
        switch number {
        case 2:
            return TileNI(image: "bolt.fill", number: 1, color: .yellow)
        case 3:
            return TileNI(image: "flame.fill", number: 2, color: .orange)
        case 4:
            return TileNI(image: "cloud.rain.fill", number: 3, color: .blue)
        case 5:
            return TileNI(image: "sun.max.fill", number: 4, color: .yellow)
        case 6:
            return TileNI(image: "moon.stars.fill", number: 5, color: .blue)
        case 7:
            return TileNI(image: "leaf.fill", number: 6, color: .green)
        case 8:
            return TileNI(image: "tornado", number: 7, color: .red)
        case 9:
            return TileNI(image: "umbrella.fill", number: 8, color: .blue)
        case 10:
            return TileNI(image: "cloud.heavyrain.fill", number: 9, color: .blue)
        case 11:
            return TileNI(image: "sunrise.fill", number: 10, color: .yellow)
        case 12:
            return TileNI(image: "cloud.sun.fill", number: 11, color: .yellow)
        case 13:
            return TileNI(image: "wind", number: 12, color: .yellow)
        case 14:
            return TileNI(image: "snowflake", number: 13, color: .yellow)
        case 15:
            return TileNI(image: "water.waves", number: 14, color: .blue)
        case 16:
            return TileNI(image: "hurricane", number: 15, color: .gray)
        case 17:
            return TileNI(image: "cloud.bolt.fill", number: 16, color: .purple)
        case 18:
            return TileNI(image: "sparkles", number: 17, color: .red)
        case 19:
            return TileNI(image: "smoke.fill", number: 18, color: .blue)
        case 20:
            return TileNI(image: "cloud.sun.bolt.fill", number: 19, color: .orange)
        case 21:
            return TileNI(image: "drop.fill", number: 20, color: .yellow)
        case 22:
            return TileNI(image: "bolt.shield.fill", number: 21, color: .purple)
        case 24:
            return TileNI(image: "bag.fill", number: 22, color: .green)
        case 25:
            return TileNI(image: "cart.fill", number: 23, color: .green)
        case 26:
            return TileNI(image: "cart.fill.badge.plus", number: 24, color: .green)
        case 27:
            return TileNI(image: "giftcard.fill", number: 25, color: .green)
        case 28:
            return TileNI(image: "banknote.fill", number: 26, color: .green)
        case 29:
            return TileNI(image: "creditcard.fill", number: 27, color: .green)
        case 30:
            return TileNI(image: "figure.walk", number: 28, color: .purple)
        case 31:
            return TileNI(image: "figure.wave", number: 29, color: .purple)
        case 32:
            return TileNI(image: "scooter", number: 30, color: .purple)
        case 33:
            return TileNI(image: "bicycle", number: 31, color: .purple)
        case 34:
            return TileNI(image: "car.fill", number: 32, color: .purple)
        case 35:
            return TileNI(image: "bolt.car.fill", number: 33, color: .purple)
        case 36:
            return TileNI(image: "box.truck.fill", number: 34, color: .purple)
        case 37:
            return TileNI(image: "bus", number: 35, color: .purple)
        case 38:
            return TileNI(image: "tram", number: 36, color: .purple)
        case 39:
            return TileNI(image: "airplane.departure", number: 37, color: .purple)
        case 40:
            return TileNI(image: "airplane", number: 38, color: .purple)
        case 41:
            return TileNI(image: "airplane.arrival", number: 39, color: .purple)
        case 42:
            return TileNI(image: "medal.fill", number: 40, color: .purple)
        default:
            return TileNI(image: "xmark.circle.fill", number: -1, color: .red)
        }
    }
    
}

// MARK: - Methods

extension TileView {
    private func titleNumber() -> String {
        guard let number = self.number else {
            return ""
        }
        let blankDictionary = [3: "", 4: "", 5: "", 6: "", 7: "", 8: "", 9: "", 10: "", 11: "", 12: "", 13: "", 14: "", 15: "", 16: "", 17: "", 18: "", 19: "", 20: "", 21: "", 22: "", 23: "", 24: "", 25: "", 26: "", 27: "" ]
        
        let numberDictionary = [3: "3", 4: "6", 5: "12", 6: "24", 7: "48", 8: "96", 9: "192", 10: "384", 11: "768", 12: "1536", 13: "3072", 14: "6144", 15: "1228", 16: "24576", 17: "49152", 18: "98304", 19: "196608" ]
        
        let letter = numberDictionary[number]
        let blankLetter = blankDictionary[number]
        
        if gameMode == "symbols" {
            return blankLetter ?? "!"
        } else {
            return letter ?? "!"
        }
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
    
    private func tileLongPress() {
        print("Long Pressed Tile: \(titleLetter())")
        showTileSheet = true
        Haptic.heavy()
    }
}
