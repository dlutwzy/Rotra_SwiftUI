//
//  IronFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class IronFactory: Factory {
    override func setup() {
        super.setup()
        
        identifier = "id.factory.Iron"
        name = "钢铁工厂"
        description = "尊严只在射程之内..."
        
        resourceName = "钢铁"
        resourceImage = "pc"
        
        type = .Iron
        scalePer50Level = 1.17
        duration = 4.0
    }
}
