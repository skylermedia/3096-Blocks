//
//  SettingsView.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Environment
    
//    @Environment(\.colorScheme) private var colorScheme: ColorScheme
//    @EnvironmentObject var adsViewModel: AdsViewModel
    
    // MARK: - Private Properties
    
    private var backgroundColor: Color = Color("signatureBlue")

    private let previewSize: CGSize = .init(width: 144, height: 144)
    
    private let plist = PlistConfiguration(name: "Strings")
    private let settings: [String : [String : String]]
    
    let settingsId: String = "ca-app-pub-3940256099942544/6300978111"
//    let settingsId: String = "ca-app-pub-8534428621909577/2232981327"
    
    // MARK: - Initializers
    
    init() {
        settings = plist?.getItem(named: PlistConfigurationKeyPath.settings.rawValue) ?? ["" : [:]]
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        List {
            Section(header:
                        VStack(alignment: .leading) {
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.gameBoardSize.rawValue] ?? "")
                    .modifier(SettingsTitleStyle())
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.gameBoardDescription.rawValue] ?? "")
                    .modifier(SettingsDescriptionStyle())
            }
            ) {
                TileBoardSettingView(
                    invertedBackgroundColor: backgroundColor,
                    previewSize: previewSize
                )
//                ColorThemePickerView()
            }
//                        BannerAd()
//            Section(header:
//                        VStack(alignment: .leading) {
//                Text("Skin Selector (Beta)")
//            .modifier(SettingsTitleStyle())
//
//                Text("Set a skin for your game tiles!")
//                    .modifier(SettingsDescriptionStyle())

//            }
//            ) {
//                SkinSelectorView(invertedBackgroundColor: invertedBackgroundColor,
//                                 previewSize: previewSize)
//            }
//            BannerAd(unitID: settingsId)
//                .frame(width: 320, height: 50)
//            Section(header: VStack(alignment: .leading) {
//                Text("Game Mode")
//                    .modifier(SettingsTitleStyle())
//                Text("Choose whether your board uses letters or numbers")
//                    .modifier(SettingsDescriptionStyle())
//            }
//            ) {
                
//                                GameModeView()
//                                Button("Show Interstitial") {
//                                    adsViewModel.showInterstitial = true
//                                }
//                                    .buttonStyle(.borderedProminent)
//            }
//            BannerAd(unitID: settingsId)
//                .frame(width: 320, height: 50)
            Section(header:
                        VStack(alignment: .leading) {
                Text("Sound Picker")
                    .modifier(SettingsTitleStyle())
                Text("Change game sounds")
                    .modifier(SettingsDescriptionStyle())
            }
            ) {
                SoundPickerView()
            }
//            BannerAd(unitID: settingsId)
//                .frame(width: 320, height: 50)
            Section(header:
                        VStack(alignment: .leading) {
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.audio.rawValue] ?? "")
                    .modifier(SettingsTitleStyle())
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.audioDescription.rawValue] ?? "")
                    .modifier(SettingsDescriptionStyle())
            }
            ) {
                AudioSettingView(
                    invertedBackground: backgroundColor,
                    previewSize: previewSize
                )
            }
//            BannerAd(unitID: settingsId)
//                .frame(width: 320, height: 50)
            Section(header:
                        VStack(alignment: .leading) {
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.haptic.rawValue] ?? "")
                    .modifier(SettingsTitleStyle())
                Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.hapticDescription.rawValue] ?? "")
                    .modifier(SettingsDescriptionStyle())
            }
            ) {
                HapticSettingsView(
                    invertedBackground: backgroundColor,
                    previewSize: previewSize
                )
            }
            .listStyle(InsetGroupedListStyle())
            .foregroundColor(.clear)
            .environment(\.horizontalSizeClass, .regular)
            .edgesIgnoringSafeArea(.bottom)
//            BannerAd(unitID: settingsId)
//                .frame(width: 320, height: 50)
        }
    }
}
