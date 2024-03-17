//
//  IceGirl.swift
//  Rotra
//
//  Created by wzy on 2024/3/17.
//

import Foundation


class IceCreator: SecondarySkill {
    
    override func setup() {
        super.setup()
        
        identifier = "id.skill.IceGirl"
        name = "冰之魔女"
        description = "冰女拥有纯粹体质，升级时不需要金币。同时，每次攻击后，获得(1+等级/20)冰霜。"
        
        requiredLevel = 0
        skillType = .Static
        
        random = 10000
    }
    
    override func action() {
        super.action()
        
        guard let hero = self.hero else {
            return
        }
        
        let value = 1 + Int64(ceil(Double(hero.level) / 20.0))
        
        engine?.resource(hero: hero, skill: self, value: value, origin: .Ice)
    }
}
