//
//  Hero.swift
//  Rotra
//
//  Created by wzy on 2024/3/12.
//

import Foundation

class Hero: Basic {
    
    var origin: Origin = .Gold
    
    // MARK: display attribute
    var imageName: String = ""
    
    // MARK: attribute
    var employed: Bool = false
    
    var level: Int {
        get { attackLevel + speedLevel + 1 }
    }
    var attackLevel: Int = 0
    var speedLevel: Int = 0
    
    var employExpend: [Expend] = [Expend]()
    var basicAttackLevelUpExpend: [Expend] = [Expend]()
    var basicSpeedLevelUpExpend: [Expend] = [Expend]()
    
    var basicAttack: Int64 = 0
    var basicSpeed: Int64 = 0
    
    var attack: Int64 = 0
    var speed: Int64 = 0
    
    var normalAttack: Skill = NormalAttack()
    var giftOne: Skill?
    var giftTwo: Skill?
    var giftThree: Skill?
    
    var learning: Skill?
    
    var skills: [Skill] {
        get {
            var skills = [Skill]()
            
            if let gift = giftOne {
                skills.append(gift)
            }
            if let gift = giftTwo {
                skills.append(gift)
            }
            if let gift = giftThree {
                skills.append(gift)
            }
            if let learn = learning {
                skills.append(learn)
            }
            
            return skills
        }
    }
    var activeSkills: [Skill] {
        get {
            var skills = [Skill]()
            
            skills.forEach { skill in
                if skill.prepared {
                    skills.append(skill)
                }
            }
            
            return skills
        }
    }
    
    weak var engine: Engine?
    
    // MARK: Running attribute
    
    required override init() {
        super.init()
    }
    
    override func setup() {
        super.setup()
    }
    
    final func load() {
        let meta = HeroMeta.load(identifier: identifier)
        if meta.circle < Engine.instance.circle {
            employed = false
            return
        }
        
        employed = meta.employed
        
        attackLevel = meta.attackLevel
        speedLevel = meta.speedLevel
        
        attack = meta.attack
        speed = meta.speed
        
        if let learningIdentifier = meta.learningIdentifier {
            for item in Engine.Template.skills {
                if (item.identifier == learningIdentifier) {
                    learning = type(of: item).init()
                    learning?.isLearning = true
                }
            }
        }
    }
    
    final func alwaysLoad() {
        guard !employed else {
            return
        }
        
        employed = true
        
        attackLevel = 0
        speedLevel = 0
        
        attack = basicAttack
        speed = basicSpeed
        
        save()
    }
    
    final func prepared() {
        
        var prepareSkills = skills
        prepareSkills.append(normalAttack)
        
        prepareSkills.forEach { skill in
            skill.engine = self.engine
            skill.prepared(hero: self)
        }
    }
    
    func tryEmploy() {
        // TODO
        engine?.tryEmploy(hero: self)
    }
    
    final func employ() {
        // Modify Data
        attackLevel = 0
        speedLevel = 0
        
        attack = basicAttack
        speed = basicSpeed
        
        employed = true
        save()
        
        prepared()
    }
    
    final func save() {
        guard let engine = self.engine else {
            return
        }
        
        let meta = HeroMeta(identifier: identifier,
                            circle: engine.circle,
                            employed: employed,
                            attackLevel: attackLevel,
                            speedLevel: speedLevel,
                            attack: attack,
                            speed: speed,
                            learningIdentifier: learning?.identifier)
        meta.save()
    }
    
    private struct HeroMeta {
        let identifier: String
        let circle: Int
        let employed: Bool
        let attackLevel: Int
        let speedLevel: Int
        let attack: Int64
        let speed: Int64
        let learningIdentifier: String?
        
        init(identifier: String, circle: Int = 0, employed: Bool = false, attackLevel: Int = 0, speedLevel: Int = 0, attack: Int64 = 0, speed: Int64 = 0, learningIdentifier: String? = nil) {
            self.identifier = identifier
            self.circle = circle
            self.employed = employed
            self.attackLevel = attackLevel
            self.speedLevel = speedLevel
            self.attack = attack
            self.speed = speed
            self.learningIdentifier = learningIdentifier
        }
        
        static func load(identifier: String) -> HeroMeta {
            let data = UserDefaults.standard.dictionary(forKey: identifier)
            return HeroMeta(identifier: identifier,
                            circle: (data?["circle"] as? Int) ?? 0,
                            employed: (data?["employed"] as? Bool) ?? false,
                            attackLevel: (data?["attackLevel"] as? Int) ?? 0,
                            speedLevel: (data?["speedLevel"] as? Int) ?? 0,
                            attack: (data?["attack"] as? Int64) ?? 0,
                            speed: (data?["speed"] as? Int64) ?? 0,
                            learningIdentifier: (data?["learningIdentifier"] as? String))
        }
        
        func save() {
            UserDefaults.standard.set([
                "circle": circle,
                "employed": employed,
                "attackLevel": attackLevel,
                "speedLevel": speedLevel,
                "attack": attack,
                "speed": speed,
                "learningIdentifier": learningIdentifier ?? false
            ], forKey: identifier)
        }
    }
}

extension Hero {
    final func timeUpdate(time: TimeInterval) {
        (normalAttack as? TimerSkill)?.timeUpdate(time: time)
    }
}

extension Hero {
    func removeSkill(skill: Skill) {
        
    }
    
    func enableSkill(skill: Skill) {
        
    }
}

extension Hero: Identifiable {
    var id: String {
        identifier
    }
}
