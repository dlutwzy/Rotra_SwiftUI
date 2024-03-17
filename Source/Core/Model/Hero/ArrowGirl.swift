//
//  ArrowGirl.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import Foundation

class ArrowGirl: Hero {
    
    override func setup() {
        super.setup()
        
        identifier = "id.hero.ArrowGirl"
        name = "女弓箭手"
        description = "也加入了保卫家园"
        imageName = "figure.archery"
        
        basicAttack = 10
        basicSpeed = 3500000
        
        employExpend = [
            Expend(origin: .Gold, value: 354)
        ]
        
        giftOne = BaQi()
    }
}
