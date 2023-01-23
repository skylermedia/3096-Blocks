////
////  SkinSelectorView.swift
////  3096 – Blocks
////
////  Created by Skyler Szijjarto on 1/19/23.
////
//
//import SwiftUI
//
//struct SkinSelectorView: View {
//    
//    // MARK: - Properties
//    
//    @Environment(\.colorScheme) var colorScheme: ColorScheme
//    
//    @State private var chosenSkin = "Default"
//    @State private var showAlert = false
//    
//    // MARK: - Colors
//    
//    private var backgroundColor: Color {
//        colorScheme == .light ? Color(red:0.43, green:0.43, blue:0.43, opacity: 1) : Color(red:0.33, green:0.33, blue:0.33, opacity: 1)
//    }
//    
//    // MARK: - Conformance to View Protocol
//    
//    var body: some View {
//        HStack {
//            Spacer()
//            VStack {
//                HStack {
//                    Spacer()
//                    // Beep
//                    CircleButton(image: Image(systemName: "tv"), text: Text("Default"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
//                        setDefaultSkin()
//                    })
//                    
//                    // Can
//                    CircleButton(image: Image(systemName: "arrow.down"), text: Text("Gradient – Red and Blue"), gradient: LinearGradient(gradient: Gradient(colors: [Color.primary.opacity(0.75), Color.primary.opacity(0.75)]), startPoint: .topLeading, endPoint: .bottomTrailing), action: {
////                        setRedBlueSkin()
//                    })
//                    Spacer()
//                }
//                Spacer()
//            }
//            .padding(5)
//            .actionSheet(isPresented: $showAlert) {
//                ActionSheet(title: Text("Requires Restart"), message: Text("You must restart 3096 – Blocks to change this setting."), buttons: [
//                    .destructive(Text("Restart"), action: {
//                        exit(EXIT_SUCCESS)
//                    }),
//                    .cancel(Text("Restart Later"), action: {
//                        // Close
//                    }),
//                ])
//            }
//        }
//    }
//        // MARK: - Functions
//        
//        func setDefaultSkin() {
//            chosenSkin = "default"
//            // User Defaults
//            UserDefaults.standard.set(chosenSkin, forKey: "chosenSkin")
//            // Logging
//            print(UserDefaults.standard.string(forKey: "chosenSkin"))
//            // Haptics
//            Haptic.light()
//            self.showAlert = true
//        }
//        
//        func setGradientSkin() {
//            chosenSkin = "gradient"
//            // User Defaults
//            UserDefaults.standard.set(chosenSkin, forKey: "chosenSkin")
//            // Logging
//            print(UserDefaults.standard.string(forKey: "chosenSkin"))
//            // Haptics
//            Haptic.light()
//            self.showAlert = true
//    }
//}
