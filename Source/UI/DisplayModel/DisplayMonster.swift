//
//  DisplayMonster.swift
//  Rotra
//
//  Created by wzy on 2024/3/14.
//

import SwiftUI


class DisplayMonster: ObservableObject, FallsSender {
    
    @Published var hp: String
    
    weak var monster: Monster?
    
    init(monster: Monster?) {
        hp = "\(monster?.hp ?? 0)"
        self.monster = monster
        monster?.delegate = self
    }
    
    weak var reveiver: FallsReceiver?
}

extension DisplayMonster: MonsterDelegate {
    func die(monster: Monster) {
        
    }
    
    func hpChanged(monster: Monster, hp: Int64) {
        DispatchQueue.main.async {
            self.hp = "\(hp)"
        }
    }
    
    func performDamage(values: Int64) {
        reveiver?.displayLabelUpdate(labels: [
            "\(values)"
        ])
    }
}
