//
//  SettingsView.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI
import MultipeerConnectivity

struct SettingsView: View {
    
    // MARK: - Environment
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    //    @EnvironmentObject var adsViewModel: AdsViewModel
    
    // MARK: - Private Properties
    
    @State private var isLoggedIn: Bool = false
    
    private var invertedBackgroundColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    private let previewSize: CGSize = .init(width: 144, height: 144)
    
    @State private var userName: String = (UserDefaults.standard.string(forKey: "userName") ?? "username")
    
    private var textColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    private var usernameTextColor: Color {
        colorScheme == .light ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    private let plist = PlistConfiguration(name: "Strings")
    private let settings: [String : [String : String]]
    
    // Test
    let settingsId: String = "ca-app-pub-3940256099942544/6300978111"
    // Production
    //    let settingsId: String = "ca-app-pub-8534428621909577/2232981327"
    
    // MARK: - Initializers
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        settings = plist?.getItem(named: PlistConfigurationKeyPath.settings.rawValue) ?? ["" : [:]]
    }
    
    // MARK: - Conformance to View Protocol
    
    var body: some View {
        NavigationView {
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
                        invertedBackgroundColor: invertedBackgroundColor,
                        previewSize: previewSize
                    )
                    //                //                ColorThemePickerView()
                }
//                                                    BannerAd()
//                                        Section(header:
//                                                    VStack(alignment: .leading) {
//                                            Text("Skin Selector (Beta)")
//                                        .modifier(SettingsTitleStyle())
//
//                                            Text("Set a skin for your game tiles!")
//                                                .modifier(SettingsDescriptionStyle())
//
//                                        }
//                                        ) {
//                                            SkinSelectorView(invertedBackgroundColor: invertedBackgroundColor,
//                                                             previewSize: previewSize)
//                                        }
//                                        BannerAd(unitID: settingsId)
//                                            .frame(width: 320, height: 50)
                Section(header: VStack(alignment: .leading) {
                    Text("Game Mode")
                        .modifier(SettingsTitleStyle())
                    Text("Choose whether your board uses letters, numbers, or symbols.")
                        .modifier(SettingsDescriptionStyle())
                }
                ) {
                    GameModeView()
                    //                                            Button("Show Interstitial") {
                    //                                                adsViewModel.showInterstitial = true
                    //                                            }
                    //                                                .buttonStyle(.borderedProminent)
                }
                //                        BannerAd(unitID: settingsId)
                //                            .frame(width: 320, height: 50)
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
                //                        BannerAd(unitID: settingsId)
                //                            .frame(width: 320, height: 50)
                Section(header:
                            VStack(alignment: .leading) {
                    Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.audio.rawValue] ?? "")
                        .modifier(SettingsTitleStyle())
                    Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.audioDescription.rawValue] ?? "")
                        .modifier(SettingsDescriptionStyle())
                }
                ) {
                    AudioSettingView(
                        invertedBackground: invertedBackgroundColor,
                        previewSize: previewSize
                    )
                }
//                            BannerAd(unitID: settingsId)
//                                .frame(width: 320, height: 50)
                Section(header:
                            VStack(alignment: .leading) {
                    Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.haptic.rawValue] ?? "")
                        .modifier(SettingsTitleStyle())
                    Text(settings[PlistConfigurationKeyPath.settings.rawValue]?[PlistConfigurationKeyPath.hapticDescription.rawValue] ?? "")
                        .modifier(SettingsDescriptionStyle())
                }
                ) {
                    HapticSettingsView(
                        invertedBackground: invertedBackgroundColor,
                        previewSize: previewSize
                    )
                    Section(header: VStack(alignment: .leading) {
                        Text("Change Username")
                            .modifier(SettingsTitleStyle())
                        Text("Change the username you set after first opening Weather Merge.")
                            .modifier(SettingsDescriptionStyle())
                    }
                    ) {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                TextField("", text: $userName)
                                    .padding()
                                    .foregroundColor(usernameTextColor)
                                    .background(backgroundColor)
                                    .cornerRadius(25)
                                Spacer()
                            }
                            if #available(iOS 15.0, *) {
                                Button("Submit") {
                                    setUserName()
                                }
                                .padding()
                                .buttonStyle(.borderedProminent)
                            } else {
                                Button("Submit") {
                                    setUserName()
                                }
                                .padding()
                                .buttonStyle(.automatic)
                            }
                            Spacer()
                        }
                    }
                }
                .listRowBackground(Color.white)
                .listStyle(InsetGroupedListStyle())
                .foregroundColor(.red)
                .environment(\.horizontalSizeClass, .regular)
                .edgesIgnoringSafeArea(.bottom)
//                BannerAd(unitID: settingsId)
//                    .frame(width: 320, height: 50)
            }
            .listRowBackground(Color.white)
        }
    }
    
    func setUserName() {
        UserDefaults.standard.set(self.userName, forKey: "userName")
        print(userName)
    }
}
