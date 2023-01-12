//
//  Audio.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import AudioToolbox

class Audio {
    private static var cachedURLs: [String : URL] = [:]
    
    static func play(fileNamed file: String, of type: String = "mp3") {
        func _play(file url: URL) {
            var sound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url as CFURL, &sound)
            AudioServicesPlaySystemSound(sound)
        }
        
        if let url = cachedURLs[file] {
            _play(file: url)
        } else {
            guard let url = Bundle.main.url(forResource: file, withExtension: type) else {
                fatalError()
            }
            cachedURLs[file] = url
            _play(file: url)
        }
    }
}
