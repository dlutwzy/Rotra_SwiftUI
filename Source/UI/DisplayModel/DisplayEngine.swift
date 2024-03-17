//
//  DisplayEngine.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

import SwiftUI

class DisplayEngine: ObservableObject {
    
    static let instance = DisplayEngine()
    
    private init() {
        let engine = Engine.instance
        
        self.engine = engine
        
        self.goldFactory = DisplayFactory(factory: engine.goldFactory)
        self.resourceFactorys = engine.factorys.map({ factory in
            DisplayFactory(factory: factory)
        })
        self.heros = engine.heros.map({ hero in
            DisplayHero(hero: hero)
        })
        self.employHeros = engine.employHeros.map({ hero in
            DisplayHero(hero: hero)
        })
        self.monster = DisplayMonster(monster: engine.currentMonster)
        
        engine.delegate = self
    }
    
    @Published var goldFactory: DisplayFactory
    @Published var resourceFactorys: [DisplayFactory]
    @Published var heros: [DisplayHero]
    @Published var employHeros: [DisplayHero]
    @Published var monster: DisplayMonster
    
    weak var engine: Engine?
}

extension DisplayEngine: EngineDelegate {
    func employeeHeroChanged(engine: Engine, heros: [Hero]) {
        guard engine === self.engine else {
            return
        }
        
        updateEmployeeHeros()
    }
    
    func currentMonsterChanged(engine: Engine, monster: Monster?) {
        guard engine === self.engine else {
            return
        }
        
        updateCurrentMonster()
    }
}

extension DisplayEngine {
    func updateEmployeeHeros() {
        guard let engine = self.engine else {
            return
        }
        
        DispatchQueue.main.async {
            self.heros = engine.heros.map({ hero in
                DisplayHero(hero: hero)
            })
        }
    }
    
    func updateCurrentMonster() {
        guard let engine = self.engine else {
            return
        }
        
        guard let monster = engine.currentMonster else {
            return
        }
        
        DispatchQueue.main.async {
            self.monster = DisplayMonster(monster: monster)
        }
    }
}
