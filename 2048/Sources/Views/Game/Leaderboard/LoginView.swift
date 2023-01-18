//
//  LoginView.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 1/16/23.
//

import SwiftUI

struct LoginView: View {
    @State private var userName: String = ""
    @State var boardSize: Int
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Please enter your username")
                TextField("Username", text: $userName)
                Button("Continue") {
                    setUserName()
                }
                NavigationLink(destination: CompositeView(board: GameLogic(size: boardSize)), isActive: $isLoggedIn) {
                    EmptyView()
                }
                .onChange(of: isLoggedIn) { value in
                    if value {
                        setUserName()
                    }
                }
            }
            .navigationBarBackButtonHidden(isLoggedIn)
        }
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
