//
//  Soldier.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class Soldier: Hero {
    override func setup() {
        super.setup()
        
        identifier = "id.hero.Soldier"
        name = "士兵"
        description = "年轻的士兵，慢慢就会变成年老的士兵"
        imageName = "figure.american.football"
        
        basicAttack = 5
        basicSpeed = 4300000
        
        employExpend = [
            Expend(origin: .Gold, value: 150)
        ]
        
        giftOne = BaQi()
    }
}
