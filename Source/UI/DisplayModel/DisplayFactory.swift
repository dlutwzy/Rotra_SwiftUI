//
//  DisplayFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

import SwiftUI
import Combine

class DisplayFactory: ObservableObject {
    var type: Origin
    @Published var level: String = "0"
    @Published var resource: String = "0"
    
    weak var factory: Factory?
    
    private var _levelDispose: DebounceObject<String>?
    private var _resourceDispose: DebounceObject<String>?
    
    init(factory: Factory) {
        
        self.factory = factory
        
        type = factory.type
        level = "\(factory.level)"
        resource = "\(factory.value)"
        
        factory.delegate = self
        
        _config()
    }
    
    private func _config() {
        _resourceDispose = DebounceObject(value: resource, debounce: { [weak self] value in
            self?.resource = value
        })
        
        _levelDispose = DebounceObject(value: level, debounce: { [weak self] value in
            self?.level = value
        })
    }
}

extension DisplayFactory: FactoryDelegate {
    func levelChanged(factory: Factory, level: Int) {
        guard factory === self.factory else {
            return
        }
        _levelDispose?.value = "\(level)"
    }
    
    func valueChanged(factory: Factory, value: Int64) {
        guard factory === self.factory else {
            return
        }
        _resourceDispose?.value = "\(value)"
    }
}

extension DisplayFactory: Identifiable {
    var id: String {
        factory?.identifier ?? ""
    }
}
