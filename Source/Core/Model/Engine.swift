//
//  Engine.swift
//  Rotra
//
//  Created by wzy on 2024/3/12.
//

import Foundation
import QuartzCore

protocol EngineDelegate: AnyObject {
    func employeeHeroChanged(engine: Engine, heros: [Hero])
    func currentMonsterChanged(engine: Engine, monster: Monster?)
}

class Engine {
    static let instance = Engine()
    private init() {}
    
    private(set) var factorys: [Factory] = [Factory]()
    private(set) var goldFactory: GoldFactory = GoldFactory()
    
    private(set) var heros: [Hero] = [Hero]()
    private(set) var mainHeros: [Hero] = [Hero]()
    private(set) var employHeros: [Hero] = [Hero]()
    
    private(set) var currentMonster: Monster? = nil
    private(set) var monsters: [Monster] = [Monster]()
    
    private(set) var autoSaveDuration: TimeInterval = 10.0
    
    weak var delegate: EngineDelegate?
    
    final func load() {
        
        factorys.removeAll()
        Engine.Template.factorys.forEach { factory in
            factorys.append(type(of: factory).init())
        }
        
        mainHeros.removeAll()
        Engine.Template.mainHeros.forEach { hero in
            let activeHero = type(of: hero).init()
            activeHero.engine = self
            activeHero.load()
            activeHero.alwaysLoad()
            mainHeros.append(activeHero)
        }
        
        employHeros.removeAll()
        Engine.Template.heros.forEach { hero in
            let activeHero = type(of: hero).init()
            activeHero.engine = self
            activeHero.load()
            employHeros.append(activeHero)
        }
        
        updateEmployHeros()
        
        updateMonsters()
    }
    
    final func prepare() {
        // Test Start
        loadTime = Date.now.timeIntervalSince1970
        currentTime = loadTime
        // Test End
        
        goldFactory.engine = self
        goldFactory.prepare()
        factorys.forEach { factory in
            factory.engine = self
            factory.prepare()
        }
        
        heros.forEach { hero in
            hero.prepared()
        }
    }
    
    final func run() {
        
        _ticktock = Ticktock(repeating: 0.005, action: { [weak self] in
            self?.timeUpdate()
        })
        
        launchTime = CACurrentMediaTime()
        calculateTime = loadTime - launchTime
        
        _ticktock?.run()
    }
    
    private func timeUpdate() {
        currentTime = calculateTime + CACurrentMediaTime()
        
        factorys.forEach { factory in
            factory.timeUpdate(time: currentTime)
        }
        
        heros.forEach { hero in
            hero.timeUpdate(time: currentTime)
        }
        
        if saveTime + autoSaveDuration < currentTime {
            saveTime = currentTime
            save()
        }
    }
    
    private(set) var circle: Int = 1
    private(set) var createTime: TimeInterval = 0
    private(set) var loadTime: TimeInterval = 0
    private(set) var calculateTime: TimeInterval = 0
    private(set) var currentTime: TimeInterval = 0
    private(set) var launchTime: TimeInterval = 0
    private(set) var deltaTime: TimeInterval = 0
    private(set) var saveTime: TimeInterval = 0
    
    private var _ticktock: Ticktock?
}

extension Engine {
    
    final func resourceReduce(values: [Origin: Int64]) -> Bool {
        return false
    }
    
    func tryEmploy(hero: Hero) {
        // TODO
        hero.employ()
        
        updateEmployHeros()
    }
    
    func updateEmployHeros() {
        
        heros.removeAll()
        mainHeros.forEach { hero in
            if hero.employed {
                heros.append(hero)
            }
        }
        employHeros.forEach { hero in
            if hero.employed {
                heros.append(hero)
            }
        }
        
        delegate?.employeeHeroChanged(engine: self, heros: heros)
    }
    
    func updateMonsters() {
        monsters.removeAll()
        Engine.Template.monsters.forEach { monster in
            monster.engine = self
            monster.load()
            monsters.append(monster)
        }
        // TODO load
        
        for monster in monsters {
            if !monster.die {
                monster.engine = self
                currentMonster = monster
                break
            }
        }
        
        currentMonster?.launch()
        delegate?.currentMonsterChanged(engine: self, monster: currentMonster)
    }
}

extension Engine {
    func damage(from hero: Hero, skill: Skill, value: Int64, origin: Origin) {
        currentMonster?.damage(from: hero, skill: skill, value: value, origin: origin)
    }
    
    func resource(hero: Hero, skill: Skill, value: Int64, origin: Origin) {
        switch origin {
        case .Gold:
            goldFactory.valueChanged(modifyValue: value)
        default:
            factorys.first {
                $0.type == origin
            }?.valueChanged(modifyValue: value)
        }
    }
}

// MARK: - Hero
extension Engine {
    func growth(hero: Hero, skill: Skill, value: Int64, growth: (_ heros: [Hero]) -> Void) {
        growth(heros)
    }
    
    func single(id: String, values: [String: Any]? = nil) {
        heros.forEach { hero in
            hero.single(id: id, values: values)
        }
    }
}

extension Engine {
    
    func resource(monster: Monster, value: Int64, origin: Origin) {
        switch origin {
        case .Gold:
            goldFactory.modify(value: value)
        default:
            factorys.first { factory in
                factory.type == origin
            }?.modify(value: value)
        }
    }
    
    func die(monster: Monster) {
        monster.save()
        
        updateMonsters()
    }
}

extension Engine {
    func save() {
        print("save")
        
        currentMonster?.save()
        
        heros.forEach { hero in
            hero.save()
        }
        
        goldFactory.save()
        factorys.forEach { factory in
            factory.save()
        }
    }
}

extension Engine {
    struct Template {
        static let skills: [Skill] = [
            NormalAttack(),
        ]
        static let mainHeros: [Hero] = [
            YouAreHero()
        ]
        static let heros: [Hero] = [
            Soldier(),
            Cook(),
            IceGirl(),
            ArrowGirl(),
            KnifeGirl(),
            Deer(),
            Monkey(),
            DemonSoldier(),
            DemonFire()
        ]
        static let monsters: [Monster] = [
            Wolf(),
            ThreeHeadWolf(),
            SmallKing(),
            FinalBoss()
        ]
        static let factorys: [Factory] = [
            RiceFactory(),
            IronFactory(),
            IceFactory(),
            FireFactory(),
            DarkFactory(),
            LightFactory()
        ]
    }
}
