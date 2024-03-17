//
//  SmallKing.swift
//  Rotra
//
//  Created by wzy on 2024/3/15.
//

import Foundation

class SmallKing: Monster {
    
    override func setup() {
        super.setup()
        
        identifier = "id.monster.SmallKing"
        name = "小人国国王"
        description = "暗黑统帅"
        
        imageName = "figure.walk"
        
        basicHp = 999999999
    }
}
