//
//  YouAreHero.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class YouAreHero: Hero {
    override func setup() {
        super.setup()
        
        identifier = "id.hero.YouAreHero"
        name = "勇士"
        description = "这就是你呀"
        imageName = "figure.roll.runningpace"
        
        basicAttack = 1
        basicSpeed = 4000000
        
        giftOne = OtherWorldHit()
        giftTwo = IceBody()
        giftThree = IceCreator()
    }
}
