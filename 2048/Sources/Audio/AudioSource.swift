//
//  AudioSource.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum AudioSource: String {
    case merge = "Merge"
    case add = "Add"
}

extension AudioSource {
    
    static func play(condition: @escaping @autoclosure () -> Bool) {
        DispatchQueue.main.async {
            if condition() {
                play(from: .moved)
            }
            play(from: .merged)
        }
    }
    
    static func play(from source: GameLogic.State) {
        switch source {
        case .merged:
            Audio.play(fileNamed: AudioSource.merge.rawValue)
        case .moved:
            Audio.play(fileNamed: AudioSource.add.rawValue)
        default:
            ()
        }
    }
}
