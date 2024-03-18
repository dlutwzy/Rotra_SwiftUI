//
//  FinalBoss.swift
//  Rotra
//
//  Created by wzy on 2024/3/18.
//

import Foundation

class FinalBoss: Monster {
    
    override func setup() {
        super.setup()
        
        identifier = "id.monster.FinalBoss"
        name = "小人国国王"
        description = "暗黑统帅"
        
        imageName = "figure.walk"
        
        basicHp = 999999999999999999
    }
}
