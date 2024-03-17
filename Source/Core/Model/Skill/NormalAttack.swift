//
//  NormalAttack.swift
//  Rotra
//
//  Created by wzy on 2024/3/12.
//

import Foundation

class NormalAttack: TimerSkill {
    
    private var expendAttackCount: Int = 0
    
    private(set) var secondarySkills: [SecondarySkill] = [SecondarySkill]()
    
    override func setup() {
        super.setup()
        
        identifier = "id.skill.NormalAttack"
        name = "普通攻击"
        description = "普普通通的一击。"
        
        requiredLevel = 0
        skillType = .Normal
        
        duration = 4.0
    }
    
    override func prepare() {
        guard let hero = self.hero else {
            return
        }
        
        duration = TimeInterval(hero.speed) / 1000000.0
        
        super.prepare()
    }
    
    override func timeUpdate(time: TimeInterval) {
        if expendAttackCount > 0 {
            action()
            expendAttackCount -= 1
        }
        
        super.timeUpdate(time: time)
    }
    
    override func action() {
        guard let hero = hero, let engine = engine else {
            return
        }
        
        engine.damage(from: hero, skill: self, value: hero.attack, origin: hero.origin)
        
        secondarySkills.forEach { skill in
            skill.trigger()
        }
    }
    
    final func pushSecondarySkill(skill: SecondarySkill) {
        guard !secondarySkills.contains(where: { $0.id == skill.id }) else {
            return
        }
        
        secondarySkills.append(skill)
    }
    
    final func pushExpendAttack(value: Int) {
        expendAttackCount += value
    }
}
