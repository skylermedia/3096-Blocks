//
//  SwiftUIExtensions.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

extension View {
    
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
}

postfix operator >*
postfix func >*<V>(lhs: V) -> AnyView where V: View {
    return lhs.eraseToAnyView()
}
