//
//  AudioSource.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum AudioSource: String {
    case merge = "Merge"
    case new = "New"
    case ding = "Ding"
    case woosh = "Woosh"
}

extension AudioSource {
    static func play(condition: @escaping @autoclosure () -> Bool) {
        DispatchQueue.main.async {
            if condition() {
                play(from: .moved)
            }
        }
    }
    
    static func play(from source: GameLogic.State) {
        switch source {
        case .merged:
            Audio.play(fileNamed: AudioSource.merge.rawValue)
        case .moved:
            Audio.play(fileNamed: AudioSource.new.rawValue)
        default:
            ()
        }
    }
    
    static func playCustom(source: AudioSource) {
        switch source {
        case .ding:
            Audio.play(fileNamed: AudioSource.ding.rawValue)
        case .woosh:
            Audio.play(fileNamed: AudioSource.woosh.rawValue)
        default:
            ()
        }
    }
}

