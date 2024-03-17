//
//  IceFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class IceFactory: Factory {
    override func setup() {
        super.setup()
        
        identifier = "id.factory.Ice"
        name = "寒霜之森"
        description = "感受绝对零度"
        
        resourceName = "冰霜"
        resourceImage = "snowflake"
        
        type = .Ice
        scalePer50Level = 1.017
        duration = 7.0
    }
}
