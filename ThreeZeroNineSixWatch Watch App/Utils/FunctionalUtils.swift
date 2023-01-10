//
//  FunctionalUtils.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Created by Skyler Szijjarto
//

func bind<T, U>(_ x: T, _ closure: (T) -> U) -> U {
    return closure(x)
}
