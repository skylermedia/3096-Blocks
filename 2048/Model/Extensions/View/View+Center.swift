//
//  View+Center.swift
//  Weather Merge
//
//  Copyright © 2023 Skyler Szijjarto
//

import SwiftUI

extension View {
    func center(in coordinateSpace: CoordinateSpace, with proxy: GeometryProxy) -> some View {
        let frame = proxy.frame(in: coordinateSpace)
        return position(x: frame.midX, y: frame.midY)
    }
}
