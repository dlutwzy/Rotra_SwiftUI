//
//  FireFactory.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

class FireFactory: Factory {
    override func setup() {
        super.setup()
        
        identifier = "id.factory.Fire"
        name = "火焰丛林"
        description = "燃尽一切"
        
        resourceName = "火焰"
        resourceImage = "flame"
        
        type = .Fire
        scalePer50Level = 1.017
        duration = 7.0
    }
}
