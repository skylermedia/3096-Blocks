//
//  CircleButton.swift
//  3096 – Blocks
//
//  Created by Skyler Szijjarto on 2/18/23.
//

import SwiftUI

struct CircleButton: View {
    let image: Image
    let text: Text
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                image
                    .font(.title)
                text
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            .padding(15)
            .background(Color.blue)
            .clipShape(Circle())
        }
    }
}
