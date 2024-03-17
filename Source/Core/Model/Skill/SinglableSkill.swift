//
//  SinglableSkill.swift
//  Rotra
//
//  Created by wzy on 2024/3/17.
//

import Foundation

class OtherWorldHit: SinglableSkill {
    
    override func setup() {
        super.setup()
        
        identifier = "id.skill.OtherWorldHit"
        name = "成长I"
        description = "攻击力等级每升1级，点击伤害增加。（等级每15级，增加量增加）。"
        
        requiredLevel = 0
        skillType = .Static
        
        singles = ["id.single.otherWorldHit"]
    }
    
    override func action() {
        guard let hero = hero, let engine = engine else {
            return
        }
        
        engine.damage(from: hero, skill: self, value: 88, origin: .Gold)
    }
}
