//
//  KnifeGirl.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import Foundation

class KnifeGirl: Hero {
    
    override func setup() {
        super.setup()
        
        identifier = "id.hero.KnifeGirl"
        name = "女刀客"
        description = "也加入了保卫家园"
        imageName = "figure.baseball"
        
        basicAttack = 12
        basicSpeed = 3700000
        
        employExpend = [
            Expend(origin: .Gold, value: 402)
        ]
        
        giftOne = BaQi()
    }
}
