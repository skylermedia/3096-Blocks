//
//  FunctionalUtils.swift
//  ThreeZeroNineSixWatch Watch App
//
//  Copyright © 2023 Skyler Szijjarto
//

func bind<T, U>(_ x: T, _ closure: (T) -> U) -> U {
    return closure(x)
}
