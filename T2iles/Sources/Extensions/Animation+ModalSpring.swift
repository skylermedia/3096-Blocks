//
//  Animation+ModalSpring.swift
//  2048
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

extension Animation {
    public static var modalSpring: Animation {
        .spring(response: 0.5, dampingFraction: 0.777, blendDuration: 0)
    }
    
    public static func modalSpring(duration: Double) -> Animation {
        .spring(response: 0.5, dampingFraction: 0.777, blendDuration: duration)
    }
}
