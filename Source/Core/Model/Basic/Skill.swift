//
//  Skill.swift
//  Rotra
//
//  Created by wzy on 2024/3/12.
//

import Foundation

class Skill: Basic {
    
    // MARK: attribute
    var skillType: SkillType = .Static
    var startingType: StartingType = .None
    
    var requiredLevel: Int = 0
    
    // MARK: running attribute
    weak var hero: Hero? {
        didSet {
            guard oldValue === hero else {
                return
            }
            if let hero = oldValue {
                hero.removeSkill(skill: self)
            }
        }
    }
    weak var engine: Engine?
    var prepared: Bool = false {
        didSet {
            guard oldValue == prepared else {
                return
            }
            if oldValue == true {
                hero?.removeSkill(skill: self)
            }
        }
    }
    
    var isLearning: Bool = false
    
    required override init() {
        super.init()
    }
    
    func action() { }
    
    func load(hero: Hero) {
        self.hero = hero
    }
    
    func prepare() {
        guard let hero = self.hero else {
            return
        }
        
        if hero.attackLevel + hero.speedLevel + 1 < requiredLevel {
            prepared = false
            return
        }
        
        prepared = true
        // TODO setup running attribute
        hero.enableSkill(skill: self)
    }
}

// MARK: Life circle
extension Skill {
    // MARK: life circle
    func removeFromHero() {
        if prepared {
            hero?.removeSkill(skill: self)
        }
        hero = nil
    }
    
    func heroUpdate(hero: Hero) {
        
    }
    
    func skillUpdate(skill: Skill) {
        
    }
}

extension Skill {
    
    func enableSkill(skill: Skill) {
        
    }
    
    func removeSkill(skill: Skill) {
        
    }
}

extension Skill: Identifiable {
    var id: String {
        (hero?.identifier ?? "") + identifier + "." + "\(isLearning ? "1" : "0")"
    }
}

class SecondarySkill: Skill {
    var random: Int = 0
    var displayRandom: Int = 0
    
    override func setup() {
        super.setup()
    }
    
    override func prepare() {
        displayRandom = random
        
        super.prepare()
    }
    
    func trigger() {
        guard _canPerfom() else {
            return
        }
        
        action()
    }
    
    private func _canPerfom() -> Bool {
        (displayRandom >= 10000) ? true : (Int.random(in: 0...10000) > random)
    }
}

class TimerSkill: Skill {
    
    var duration: TimeInterval = 4.0
    var timeScale: Double = 1.0
    var displayDuration: TimeInterval = 0.0
    var lastUpdateTime: TimeInterval = 0.0
    var nextUpdateTime: TimeInterval = 0.0
    
    func timeUpdate(time: TimeInterval) {
        guard time > nextUpdateTime else {
            return
        }
        
        action()
        
        // TODO
        lastUpdateTime = nextUpdateTime
        nextUpdateTime += duration
    }
    
    func timeScaleChanged() {
        
    }
    
    override func prepare() {
        super.prepare()
        
        if !prepared {
            return
        }
        
        lastUpdateTime = engine?.currentTime ?? 0
        nextUpdateTime = lastUpdateTime + duration
    }
    
    private struct TimerSkillMeta {
        var identifier: String
        var lastUpdateTime: TimeInterval
        var nextUpdateTime: TimeInterval
        var extInfo: [String: Any]
    }
}

class SinglableSkill: Skill {
    
    var singles: [String] = [String]()
    
    final func single(id: String, values: [String: Any]? = nil) {
        guard canSingle(id: id, values: values) else {
            return
        }
        
        action()
    }
    
    func canSingle(id: String, values: [String: Any]?) -> Bool {
        return singles.contains(id)
    }
}
