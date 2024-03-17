//
//  RALock.swift
//  Rotra
//
//  Created by wzy on 2023/7/23.
//

import Foundation

struct MutexLock {
    
    func run(_ action: () -> Void) {
        _semphore.wait()
        action()
        _semphore.signal()
    }
    
    private let _semphore = DispatchSemaphore(value: 1)
}
