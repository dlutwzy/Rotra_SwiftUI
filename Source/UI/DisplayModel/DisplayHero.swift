//
//  DisplayHero.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

import SwiftUI
import Combine

class DisplayHero: ObservableObject {
    
    @Published var name: String
    var imageName: String
    @Published var level: String
    @Published var attackLevel: String
    @Published var speedLevel: String
    @Published var attack: String
    @Published var speed: String
    
    private var _levelDispose: DebounceObject<String>?
    private var _attackDispose: DebounceObject<String>?
    private var _speedDispose: DebounceObject<String>?
    
    weak var hero: Hero?
    
    init(hero: Hero) {
        self.hero = hero
        
        name = hero.name
        imageName = hero.imageName
        level = "\(hero.level)"
        attackLevel = "\(hero.attackLevel)"
        speedLevel = "\(hero.speedLevel)"
        attack = "\(hero.attack)"
        speed = "\(String(format: "%.3f", hero.displaySpeed))"
        
        hero.delegate = self
        
        _config()
    }
    
    private func _config() {
        
        _levelDispose = DebounceObject(value: level, debounce: { [weak self] value in
            self?.level = value
        })
        
        _attackDispose = DebounceObject(value: attack, debounce: { [weak self] value in
            self?.attack = value
        })
        
        _speedDispose = DebounceObject(value: speed, debounce: { [weak self] value in
            self?.level = value
        })
    }
}

extension DisplayHero: HeroDelegate {
    func levelUp(hero: Hero, value: Int64) {
        guard hero === self.hero else {
            return
        }
        
        DispatchQueue.main.async {
            self.level = "\(value)"
        }
    }
    
    func attackValueChanged(hero: Hero, value: Int64) {
        guard hero === self.hero else {
            return
        }
        
        let text = "\(value)"
        _attackDispose?.value = text
    }
    
    func speedValueChanged(hero: Hero, value: Int64) {
        guard hero === self.hero else {
            return
        }
        
        DispatchQueue.main.async {
            self.speed = "\(String(format: "%.3f", hero.displaySpeed))"
        }
    }
    
    
}

extension DisplayHero: Identifiable {
    var id: String {
        hero?.identifier ?? ""
    }
}
