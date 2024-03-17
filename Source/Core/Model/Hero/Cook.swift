//
//  Cook.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import Foundation

class Cook: Hero {
    
    override func setup() {
        super.setup()
        
        identifier = "id.hero.Cook"
        name = "厨子"
        description = "做饭的厨子，也加入了保卫家园"
        imageName = "figure.badminton"
        
        basicAttack = 5
        basicSpeed = 4500000
        
        employExpend = [
            Expend(origin: .Gold, value: 150)
        ]
        
        giftOne = BaQi()
    }
}
