//
//  RiceFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation


class RiceFactory: Factory {
    override func setup() {
        super.setup()
        
        identifier = "id.factory.Rice"
        name = "面包作坊"
        description = "人是铁，饭是钢"
        
        resourceName = "面包"
        resourceImage = "frying.pan"
        
        type = .Rice
        scalePer50Level = 1.17
        duration = 3.0
    }
}
