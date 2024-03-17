//
//  Wolf.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class Wolf: Monster {
    
    override func setup() {
        super.setup()
        
        identifier = "id.monster.Wolf"
        name = "狼"
        description = "就是一头狼"
        
        imageName = "bicycle"
        
        basicHp = 9
    }
}
