//
//  DisplayFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

import SwiftUI

class DisplayFactory: ObservableObject {
    var type: Origin
    @Published var level: String = "0"
    @Published var resource: String = "0"
    
    weak var factory: Factory?
    
    init(factory: Factory) {
        
        self.factory = factory
        
        type = factory.type
        level = "\(factory.level)"
        resource = "\(factory.value)"
        
        factory.delegate = self
    }
}

extension DisplayFactory: FactoryDelegate {
    func levelChanged(factory: Factory, level: Int) {
        DispatchQueue.main.async {
            self.level = "\(level)"
        }
    }
    
    func valueChanged(factory: Factory, value: Int64) {
        DispatchQueue.main.async {
            self.resource = "\(value)"
        }
    }
}

extension DisplayFactory: Identifiable {
    var id: String {
        factory?.identifier ?? ""
    }
}
