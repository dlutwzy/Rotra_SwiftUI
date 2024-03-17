//
//  DebouncedObservableObject.swift
//  Rotra
//
//  Created by wzy on 2024/3/17.
//

import Foundation
import Combine

//class DebounceObject {
//    private let property = CurrentValueSubject<String, Never>("")
//
//    @Published var value: String {
//        didSet {
//            property.send(value)
//        }
//    }
//
//    let debouncedPublisher: AnyPublisher<String, Never>
//
//    init(value: String = "", duartion: TimeInterval = 0.1) {
//        self.value = value
//
//        debouncedPublisher = property.debounce(
//            for: .seconds(duartion),
//            scheduler: RunLoop.main
//        ).eraseToAnyPublisher()
//    }
//}

class DebounceObject<Output> {
    
    private let _property: CurrentValueSubject<Output, Never>
    
    @Published var value: Output {
        didSet {
            _property.send(value)
        }
    }
    
    private let _debouncedPublisher: AnyPublisher<Output, Never>
    private let _cancelable: AnyCancellable
    
    init(value: Output, duartion: TimeInterval = 0.1, debounce: @escaping ((Output) -> Void)) {
        _property = CurrentValueSubject(value)
        
        self.value = value
        
        _debouncedPublisher = _property.debounce(
            for: .seconds(duartion),
            scheduler: RunLoop.main
        ).eraseToAnyPublisher()
        
        _cancelable = _debouncedPublisher.sink(receiveValue: debounce)
    }
    
    deinit {
        _cancelable.cancel()
    }
}
