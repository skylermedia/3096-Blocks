//
//  CircleButton.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 2/18/23.
//

import SwiftUI

struct CircleButton: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    let sfImage: Bool
    let image: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.primary.opacity(0.75))
                VStack {
                    if sfImage {
                        Image(systemName: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                    } else {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                    }
                }
            }
            .frame(width: 75, height: 75)
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .onTapGesture {
                action()
            }
            
            Text(text)
                .font(.callout.bold())
        }
    }
}
