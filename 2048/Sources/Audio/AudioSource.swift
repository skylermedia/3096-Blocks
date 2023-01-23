//
//  AudioSource.swift
//  3096 – Blocks
//
//  Copyright © 2023 Skyler Szijjarto
//

import Foundation

enum AudioSource: String {
    case beep = "Beep"
    case can = "Can"
    case click = "Click"
    case hit = "Hit"
    case plant = "Plant"
    case toy = "Toy"
    case boing = "Boing"
    case wood = "Wood"
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
        case .beep:
            Audio.play(fileNamed: AudioSource.beep.rawValue)
        case .can:
            Audio.play(fileNamed: AudioSource.can.rawValue)
        case .click:
            Audio.play(fileNamed: AudioSource.click.rawValue)
        case .hit:
            Audio.play(fileNamed: AudioSource.hit.rawValue)
        case .plant:
            Audio.play(fileNamed: AudioSource.plant.rawValue)
        case .toy:
            Audio.play(fileNamed: AudioSource.toy.rawValue)
        case .boing:
            Audio.play(fileNamed: AudioSource.boing.rawValue)
        case .wood:
            Audio.play(fileNamed: AudioSource.wood.rawValue)
        default:
            ()
        }
    }
}

