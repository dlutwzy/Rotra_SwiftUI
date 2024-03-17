//
//  BaQi.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class BaQi: TimerSkill {
    
    override func setup() {
        super.setup()
        
        identifier = "id.skill.BaQi"
        name = "八岐"
        description = "每60秒，发动一次8连攻击。"
        
        requiredLevel = 0
        skillType = .Magic
        
//        duration = 60.0
        duration = 6.0
    }
    
    override func action() {
        super.action()
        
        (hero?.normalAttack as? NormalAttack)?.pushExpendAttack(value: 8)
    }
}
