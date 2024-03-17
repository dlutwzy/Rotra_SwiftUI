//
//  Monkey.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import Foundation

class Monkey: Hero {
    
    override func setup() {
        super.setup()
        
        identifier = "id.hero.Monkey"
        name = "猴子"
        description = "也加入了保卫家园"
        imageName = "figure.wrestling"
        
        basicAttack = 113
        basicSpeed = 3400000
        
        employExpend = [
            Expend(origin: .Gold, value: 4681),
            Expend(origin: .Rice, value: 20)
        ]
        
        giftOne = BaQi()
    }
}
