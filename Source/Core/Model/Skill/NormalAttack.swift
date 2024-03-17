//
//  NormalAttack.swift
//  Rotra
//
//  Created by wzy on 2024/3/12.
//

import Foundation

class NormalAttack: TimerSkill {
    
    var secondarySkills: [Skill] = [Skill]()
    
    override func prepared(hero: Hero) {
        duration = TimeInterval(hero.speed) / 1000000.0
        
        super.prepared(hero: hero)
    }
    
    override func action() {
        guard let hero = hero, let engine = engine else {
            return
        }
        
        engine.damage(from: hero, skill: self, value: hero.attack, origin: hero.origin)
    }
}
