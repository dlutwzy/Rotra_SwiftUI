//
//  Deer.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import Foundation

class Deer: Hero {
    
    override func setup() {
        super.setup()
        
        identifier = "id.hero.Deer"
        name = "小鹿"
        description = "也加入了保卫家园"
        imageName = "figure.yoga"
        
        basicAttack = 100
        basicSpeed = 3600000
        
        employExpend = [
            Expend(origin: .Gold, value: 4142),
            Expend(origin: .Rice, value: 20)
        ]
        
        giftOne = BaQi()
    }
}
