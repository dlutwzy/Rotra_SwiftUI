//
//  Monster.swift
//  Rotra
//
//  Created by wzy on 2024/3/12.
//

import Foundation

protocol MonsterDelegate: AnyObject {
    func performDamage(values: Int64)
    func hpChanged(monster: Monster, hp: Int64)
    func die(monster: Monster)
}

class Monster: Basic {
    
    weak var delegate: MonsterDelegate?
    
    var imageName: String = ""
    
    var basicHp: Int64 = 0
    
    var hp: Int64 = 0 {
        didSet {
            delegate?.hpChanged(monster: self, hp: hp)
        }
    }
    var die: Bool = false
    
    weak var engine: Engine?
    
    required override init() {
        super.init()
    }
    
    func damage(from: Hero, skill: Skill, value: Int64, origin: Origin) {
        hp -= value
        delegate?.performDamage(values: value)
        engine?.resource(monster: self, value: value, origin: .Gold)
        if hp <= 0 {
            self.die = true
            delegate?.die(monster: self)
            engine?.die(monster: self)
        }
    }
    
    final func load() {
        guard let engine = self.engine else {
            return
        }
        
        let meta = MonsterMeta.load(identifier: identifier)
        if meta.circle < engine.circle {
            die = false
            return
        }
        
        hp = meta.hp
        die = meta.die
    }
    
    final func prepared() {
        
    }
    
    final func launch() {
        guard let engine = self.engine else {
            return
        }
        let meta = MonsterMeta.load(identifier: identifier)
        guard meta.circle != engine.circle else {
            return
        }
        
        hp = basicHp
        die = false
        
        save()
    }
    
    final func save() {
        guard let engine = self.engine else {
            return
        }
        
        let meta = MonsterMeta(
            identifier: identifier,
            hp: hp,
            circle: engine.circle,
            die: die
        )
        meta.save()
    }
    
    private struct MonsterMeta {
        let identifier: String
        let circle: Int
        let hp: Int64
        let die: Bool
        
        init(identifier: String, hp: Int64 = 0, circle: Int = 0, die: Bool = false) {
            self.identifier = identifier
            self.circle = circle
            self.hp = hp
            self.die = die
        }
        
        static func load(identifier: String) -> MonsterMeta {
            let data = UserDefaults.standard.dictionary(forKey: identifier)
            return MonsterMeta(
                identifier: identifier,
                hp: (data?["hp"] as? Int64) ?? 0,
                circle: (data?["circle"] as? Int) ?? 0,
                die: (data?["die"] as? Bool) ?? false
            )
        }
        
        func save() {
            UserDefaults.standard.set([
                "circle": circle,
                "hp": hp,
                "die": die
            ], forKey: identifier)
        }
    }
}
