//
//  SwiftUIExtensions.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Created by Skyler Szijjarto
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
