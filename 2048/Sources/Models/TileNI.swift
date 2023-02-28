//
//  TileNI.swift
//  Weather Merge
//
//  Created by Skyler Szijjarto on 2/27/23.
//

import Foundation
import SwiftUI

struct TileNI: View {
    var image: String
    var number: String
    var color: Color
    
    @State private var selection = GameBoardSizeState()

    var body: some View {
        ZStack {
            Image(systemName: image)
                .font(.monospaced(.title)())
                .foregroundColor(color)
                .font(.largeTitle)
            
            if selection.is3x3On {
                Text(number)
                    .offset(x: 25, y: 25)
                    .font(.title)
                    .fontWeight(.black)
            }
            
            if selection.is4x4On {
                Text(number)
                    .offset(x: 25, y: 25)
                    .font(.body)
                    .fontWeight(.black)
            }
            
            if selection.is5x5On {
                Text(number)
                    .offset(x: 20, y: 20)
                    .font(.body)
                    .fontWeight(.black)
            }
            
            if selection.is6x6On {
                Text(number)
                    .offset(x: 17, y: 17)
                    .font(.caption)
                    .fontWeight(.black)
            }
        }
    }
}
