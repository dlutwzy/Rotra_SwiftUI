//
//  Factory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

protocol FactoryDelegate: AnyObject {
    func levelChanged(factory: Factory, level: Int)
    func valueChanged(factory: Factory, value: Int64)
}

class Factory: Basic {
    var type: Origin = .Gold
    
    var resourceName: String = ""
    var resourceImage: String = ""
    
    var level: Int = 0
    
    var scalePer50Level: Double = 1.0
    
    var duration: TimeInterval = 4.0
    var displayDuration: TimeInterval = 0.0
    
    var value: Int64 = 0
    
    var lastUpdateTime: TimeInterval = 0.0
    var nextUpdateTime: TimeInterval = 0.0
    
    private var prepared: Bool {
        level > 0
    }
    
    weak var engine: Engine?
    weak var delegate: FactoryDelegate?
    
    required override init() {
        super.init()
    }
    
    func timeUpdate(time: TimeInterval) {
        guard prepared else {
            return
        }
        
        guard time > nextUpdateTime else {
            return
        }
        
        let value = Int64(Double(level) * pow(scalePer50Level, Double(Int(level / 50))))
        valueChanged(modifyValue: value)
        
        lastUpdateTime = nextUpdateTime
        nextUpdateTime = lastUpdateTime + duration
    }
    
    final func valueChanged(modifyValue: Int64) {
        value += modifyValue
        delegate?.valueChanged(factory: self, value: value)
    }
    
    func prepare() {
        guard let engine = self.engine else {
            return
        }
        
        let meta = FactoryMeta.load(identifier: identifier)
        if meta.circle < engine.circle {
            level = 0
            value = 0
            
            lastUpdateTime = engine.currentTime
            
            save()
        } else {
            level = meta.level
            value = meta.value
            
            lastUpdateTime = meta.lastUpdateTime
        }
        
        nextUpdateTime = lastUpdateTime + duration
    }
    
    func tryLevelUp(deltaLevel: Int) {
        
        level += deltaLevel
        if level == deltaLevel {
            lastUpdateTime = engine?.currentTime ?? 0.0
            save()
        }
        
        delegate?.levelChanged(factory: self, level: level)
    }
    
    func modify(value: Int64) {
        self.value += value
        delegate?.valueChanged(factory: self, value: self.value)
    }
    
    final func save() {
        guard let engine = self.engine else {
            return
        }
        
        let meta = FactoryMeta(
            identifier: identifier,
            value: value,
            circle: engine.circle,
            level: level,
            lastUpdateTime: lastUpdateTime
        )
        meta.save()
    }
    
    private struct FactoryMeta {
        let identifier: String
        let level: Int
        let value: Int64
        let circle: Int
        let lastUpdateTime: TimeInterval
        
        init(identifier: String, value: Int64 = 0, circle: Int = 0, level: Int = 0, lastUpdateTime: TimeInterval = 0) {
            self.identifier = identifier
            self.circle = circle
            self.level = level
            self.value = value
            self.lastUpdateTime = lastUpdateTime
        }
        
        static func load(identifier: String) -> FactoryMeta {
            let data = UserDefaults.standard.dictionary(forKey: identifier)
            return FactoryMeta(
                identifier: identifier,
                value: (data?["value"] as? Int64) ?? 0,
                circle: (data?["circle"] as? Int) ?? 0,
                level: (data?["level"] as? Int) ?? 0,
                lastUpdateTime: (data?["lastUpdateTime"] as? TimeInterval) ?? 0
            )
        }
        
        func save() {
            UserDefaults.standard.set([
                "circle": circle,
                "value": value,
                "level": level,
                "lastUpdateTime": lastUpdateTime
            ], forKey: identifier)
        }
    }
}
