//
//  RATimer.swift
//  Rotra
//
//  Created by wzy on 2023/7/22.
//

import Foundation
import QuartzCore

class Ticktock {
    
    private let _action: (() -> Void)
    
    init(repeating: TimeInterval? = nil, performQueue: DispatchQueue? = nil, action: @escaping (() -> Void)) {
        self._action = action
        if let queue = performQueue {
            _queue = queue
        } else {
            _queue = DispatchQueue(label: "com.asima.rotra.timer")
        }
        
        _timer = DispatchSource.makeTimerSource(queue: _queue)
        let duration = repeating ?? ConstValues.timerDuration
        _timer.schedule(wallDeadline: .now(), repeating: .milliseconds(Int(duration * 1000.0)), leeway: .nanoseconds(0))
        _timer.setEventHandler(handler: DispatchWorkItem(block: { [weak self] in
            self?._action()
        }))
    }
    
    deinit {
        _timer.cancel()
    }
    
    func run() {
        _timer.resume()
    }
    
    private let _queue: DispatchQueue
    private let _timer: DispatchSourceTimer
    
    private struct ConstValues {
        static let timerDuration: TimeInterval = 0.005
    }
}
