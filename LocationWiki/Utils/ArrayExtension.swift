//
//  ArrayExtension.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 24/11/2021.
//

import Foundation

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
