////
////  ColorThemePickerView.swift
////  Weather Merge
////
////  Created by Skyler Szijjarto on 1/19/23.
////
//
//import SwiftUI
//
//enum ColorTheme {
//    case `default`
//    case dark
//    case custom
//}
//
//class ColorThemeManager: ObservableObject {
//    @AppStorage("selectedTheme") var selectedTheme: ColorTheme = .default
//    @AppStorage("backgroundColor") var backgroundColor = Color.white
//    @AppStorage("textColor") var textColor = Color.black
//}
//
//struct ColorThemePickerView: View {
//    @EnvironmentObject var colorThemeManager: ColorThemeManager
//    var body: some View {
//        VStack {
//            Text("Select Color Theme")
//            Picker(selection: $colorThemeManager.selectedTheme, label: Text("")) {
//                Text("Default").tag(ColorTheme.default)
//                Text("Dark").tag(ColorTheme.dark)
//                Text("Custom").tag(ColorTheme.custom)
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding()
//            if colorThemeManager.selectedTheme == .custom {
//                CustomColorPickerView()
//            }
//        }
//    }
//}
//
//struct CustomColorPickerView: View {
//    @EnvironmentObject var colorThemeManager: ColorThemeManager
//    var body: some View {
//        VStack {
//            Text("Background Color")
//            ColorPicker("", selection: $colorThemeManager.backgroundColor)
//            Text("Text Color")
//            ColorPicker("", selection: $colorThemeManager.textColor)
//        }
//    }
//}
