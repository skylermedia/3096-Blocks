//
//  CircleButton.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 2/18/23.
//

import SwiftUI

struct CircleButton: View {
    let image: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 65, height: 65)
                Button(action: action) {
                    VStack(spacing: 4) {
                        Image(systemName: image)
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.blue)
                    .clipShape(Circle())
                }
            }
            Text(text)
                .font(.callout.bold())
        }
    }
}
