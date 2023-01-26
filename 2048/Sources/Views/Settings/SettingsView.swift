//
//  SettingsView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Environment
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @EnvironmentObject var adsViewModel: AdsViewModel
    
    // MARK: - Private Properties
    
    private var invertedBackgroundColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    private let previewSize: CGSize = .init(width: 144, height: 144)
    
    private let plist = PlistConfiguration(name: "Strings")
    private let settings: [String : [String : String]]
    
    // MARK: - Initializers
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        settings = plist?.getItem(named: PlistConfigurationKeyPath.settings.rawValue) ?? ["" : [:]]
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        List {
            Section(header:
                        VStack(alignment: .leading) {
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.gameBoardSize.rawValue] ?? "")
                    .font(.system(.title, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.black)
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.gameBoardDescription.rawValue] ?? "")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.bold)
            }
            ) {
                TileBoardSettingView(
                    invertedBackgroundColor: invertedBackgroundColor,
                    previewSize: previewSize
                )
//                ColorThemePickerView()
            }
//                        BannerAd(unitID: "ca-app-pub-3940256099942544/6300978111")
//                .frame(maxWidth: 320, maxHeight: 50)
//            Section(header:
//                        VStack(alignment: .leading) {
//                Text("Skin Selector (Beta)")
//                    .font(.system(.title, design: .monospaced))
//                    .foregroundColor(Color.primary.opacity(0.5))
//                    .fontWeight(.black)
//                Text("Set a skin for your game tiles!")
//                    .font(.system(.body, design: .monospaced))
//                    .foregroundColor(Color.primary.opacity(0.5))
//                    .fontWeight(.bold)
//            }
//            ) {
//                SkinSelectorView(invertedBackgroundColor: invertedBackgroundColor,
//                                 previewSize: previewSize)
//            }
                        BannerAd(unitID: "ca-app-pub-3940256099942544/6300978111")
                .frame(maxWidth: 320, maxHeight: 50)
            Section(header:
                        VStack(alignment: .leading) {
                Text("Game Mode")
                    .font(.system(.title, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.black)
                Text("Choose whether your board uses letters or numbers")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.bold)
            }
            ) {
                GameModeView()
//                Button("Show Interstitial") {
//                    adsViewModel.showInterstitial = true
//                }
//                    .buttonStyle(.borderedProminent)
            }
                        BannerAd(unitID: "ca-app-pub-3940256099942544/6300978111")
                .frame(maxWidth: 320, maxHeight: 50)
            Section(header:
                        VStack(alignment: .leading) {
                Text("Sound Picker")
                    .font(.system(.title, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.black)
                Text("Change game sounds")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.bold)
            }
            ) {
                SoundPickerView()
            }
                        BannerAd(unitID: "ca-app-pub-3940256099942544/6300978111")
                .frame(maxWidth: 320, maxHeight: 50)
            Section(header:
                        VStack(alignment: .leading) {
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.audio.rawValue] ?? "")
                    .font(.system(.title, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.black)
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.audioDescription.rawValue] ?? "")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.bold)
            }
            ) {
                AudioSettingView(
                    invertedBackground: invertedBackgroundColor,
                    previewSize: previewSize
                )
            }
                        BannerAd(unitID: "ca-app-pub-3940256099942544/6300978111")
                .frame(maxWidth: 320, maxHeight: 50)
            Section(header:
                        VStack(alignment: .leading) {
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.haptic.rawValue] ?? "")
                    .font(.system(.title, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.black)
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.hapticDescription.rawValue] ?? "")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .fontWeight(.bold)
            }
            ) {
                HapticSettingsView(
                    invertedBackground: invertedBackgroundColor,
                    previewSize: previewSize
                )
            }
            .listStyle(InsetGroupedListStyle())
            .foregroundColor(.clear)
            .environment(\.horizontalSizeClass, .regular)
            .edgesIgnoringSafeArea(.bottom)
            BannerAd(unitID: "ca-app-pub-3940256099942544/6300978111")
                .frame(maxWidth: 320, maxHeight: 50)
        }
    }
}
