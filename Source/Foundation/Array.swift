//
//  Array.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

extension Array {
    func chunked(intoSize size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0...($0+3)])
        }
    }
}
