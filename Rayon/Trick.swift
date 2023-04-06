//
//  Trick.swift
//  Rayon
//
//  Created by 李浩安 on 2023/4/4.
//

import SwiftUI

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

func isEqual<T: Equatable>(type: T.Type, lhs: Any, rhs: Any) -> Bool {
    guard let a = lhs as? T, let b = rhs as? T else { return false }

    return a == b
}
