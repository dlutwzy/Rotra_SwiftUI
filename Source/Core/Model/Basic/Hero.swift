//
//  Hero.swift
//  Rotra
//
//  Created by wzy on 2024/3/12.
//

import Foundation

protocol HeroDelegate: AnyObject {
    func levelUp(hero: Hero, value: Int64)
    func attackValueChanged(hero: Hero, value: Int64)
    func speedValueChanged(hero: Hero, value: Int64)
}

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
    var displaySpeed: Double { Double(speed) / 1000000.0 }
    
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
            var array = [Skill]()
            
            self.skills.forEach { skill in
                if skill.prepared {
                    array.append(skill)
                }
            }
            
            return array
        }
    }
    
    weak var engine: Engine?
    
    weak var delegate: HeroDelegate?
    
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
        
        normalAttack.load(hero: self)
        skills.forEach { skill in
            skill.load(hero: self)
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
            skill.prepare()
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
    
    struct StaticValues {
        static let maxAttack: Int64 = 9000000000000000000
        static let minSpeed: Int64 = 20000
    }
}

extension Hero {
    func timeUpdate(time: TimeInterval) {
        (normalAttack as? TimerSkill)?.timeUpdate(time: time)
        
        activeSkills.forEach { skill in
            (skill as? TimerSkill)?.timeUpdate(time: time)
        }
    }
    
    func single(id: String, values: [String: Any]?) {
        skills.forEach { skill in
            (skill as? SinglableSkill)?.single(id: id, values: values)
        }
    }
}

// MARK: -Hero
extension Hero {
    func attackValueChanged(value: Int64) {
        let newValue =  Double(attack) + Double(value)
        attack = newValue < Double(StaticValues.maxAttack) ? Int64(newValue) : StaticValues.maxAttack
        
        delegate?.attackValueChanged(hero: self, value: attack)
    }
    
    func speedValueChanged(value: Int64) {
        let newValue =  Double(speed) + Double(value)
        speed = newValue > Double(StaticValues.minSpeed) ? Int64(newValue) : StaticValues.minSpeed
        
        delegate?.speedValueChanged(hero: self, value: speed)
    }
}

extension Hero {
    func removeSkill(skill: Skill) {
        
    }
    
    func enableSkill(skill: Skill) {
        
        if let secondarySkill = skill as? SecondarySkill {
            (normalAttack as? NormalAttack)?.pushSecondarySkill(skill: secondarySkill)
        }
    }
}

extension Hero: Identifiable {
    var id: String {
        identifier
    }
}
