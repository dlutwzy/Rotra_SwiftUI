//
//  DemonSoldier.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import Foundation

class DemonSoldier: Hero {
    
    override func setup() {
        super.setup()
        
        identifier = "id.hero.DemonSoldier"
        name = "妖精战士"
        description = "也加入了保卫家园"
        imageName = "figure.badminton"
        
        basicAttack = 160
        basicSpeed = 3400000
        
        employExpend = [
            Expend(origin: .Gold, value: 7725),
            Expend(origin: .Rice, value: 30)
        ]
        
        giftOne = BaQi()
    }
}
