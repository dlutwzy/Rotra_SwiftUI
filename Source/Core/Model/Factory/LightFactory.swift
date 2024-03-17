//
//  LightFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class LightFactory: Factory {
    override func setup() {
        super.setup()
        
        identifier = "id.factory.Light"
        name = "光明殿堂"
        description = "也是伸手不见五指"
        
        resourceName = "神圣"
        resourceImage = "sun.max"
        
        type = .Light
        scalePer50Level = 1.17
        duration = 12.0
    }
}
