//
//  IceBody.swift
//  Rotra
//
//  Created by wzy on 2024/3/17.
//

import Foundation

class IceBody: SecondarySkill {
    
    override func setup() {
        super.setup()
        
        identifier = "id.skill.IceBody"
        name = "冰霜之躯"
        description = "冰之女儿每次攻击后，获得(1+等级/12)攻击力。"
        
        requiredLevel = 0
        skillType = .Static
        
        random = 10000
    }
    
    override func action() {
        super.action()
        
        guard let hero = self.hero else {
            return
        }
        
        let value = 1 + Int64(ceil(Double(hero.level) / 12.0))
        
        hero.attackValueChanged(value: value)
    }
}
