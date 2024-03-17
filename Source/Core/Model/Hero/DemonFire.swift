//
//  DemonFire.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import Foundation

class DemonFire: Hero {
    
    override func setup() {
        super.setup()
        
        identifier = "id.hero.DemonFire"
        name = "妖精火术士"
        description = "也加入了保卫家园"
        imageName = "figure.seated.side.airbag.on"
        
        basicAttack = 150
        basicSpeed = 4700000
        
        employExpend = [
            Expend(origin: .Gold, value: 7242),
            Expend(origin: .Fire, value: 20)
        ]
        
        giftOne = BaQi()
    }
}
