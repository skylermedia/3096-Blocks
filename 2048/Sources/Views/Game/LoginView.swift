//
//  LoginView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/16/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    @State private var userName: String = ""
    @State var boardSize: Int
    @State private var isLoggedIn: Bool = false
    
    private var textColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    private var usernameTextColor: Color {
        colorScheme == .light ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color(red:0.90, green:0.90, blue:0.90, opacity:1.00) : Color(red:0.10, green:0.10, blue:0.10, opacity:1.00)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Enter a Username Below")
                    .bold()
                    .font(.title)
                    .foregroundColor(textColor)
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
                NavigationLink(destination: CompositeView(board: GameLogic(size: boardSize)), isActive: $isLoggedIn) {
                    EmptyView()
                }
                .onChange(of: isLoggedIn) { value in
                    if value {
                        setUserName()
                    }
                }
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(isLoggedIn)
    }
    
    func setUserName() {
        isLoggedIn = true
        UserDefaults.standard.set(self.userName, forKey: "userName")
        UserDefaults.standard.set(self.isLoggedIn, forKey: "isAuthenticated")
    }
}

struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView(boardSize: 4)
    }
}
