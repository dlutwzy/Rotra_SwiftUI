//
//  DarkFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class DarkFactory: Factory {
    override func setup() {
        super.setup()
        
        identifier = "id.factory.Dark"
        name = "幽暗深渊"
        description = "伸手不见五指"
        
        resourceName = "魔能"
        resourceImage = "moon.stars"
        
        type = .Dark
        scalePer50Level = 1.17
        duration = 10.0
    }
}
