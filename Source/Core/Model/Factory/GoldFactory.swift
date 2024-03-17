//
//  GoldFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class GoldFactory: Factory {
    override func setup() {
        super.setup()
        
        identifier = "id.factory.Gold"
        name = "钱"
        description = "只是钱"
        
        resourceName = "金币"
        resourceImage = "bitcoinsign.circle.fill"
        
        type = .Gold
        scalePer50Level = 1.0
        duration = 0.0
    }
}
