//
//  ThreeHeadWolf.swift
//  Rotra
//
//  Created by wzy on 2024/3/15.
//

import Foundation


class ThreeHeadWolf: Monster {
    
    override func setup() {
        super.setup()
        
        identifier = "id.monster.ThreeHeadWolf"
        name = "三头狼"
        description = "三头狼又怎样"
        
        imageName = "scooter"
        
        basicHp = 9999999
    }
}
