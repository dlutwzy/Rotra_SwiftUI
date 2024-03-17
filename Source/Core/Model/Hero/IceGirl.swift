//
//  IceGirl.swift
//  Rotra
//
//  Created by wzy on 2024/3/17.
//

import Foundation

class IceGirl: Hero {
    override func setup() {
        super.setup()
        
        identifier = "id.hero.IceGirl"
        name = "冰女"
        description = "这是一只冰女"
        imageName = "figure.snowboarding"
        
        basicAttack = 1
        basicSpeed = 1000000
        
        giftOne = BaQi()
        giftTwo = IceBody()
        giftThree = IceCreator()
    }
}
