//
//  Basic.swift
//  Rotra
//
//  Created by wzy on 2024/3/12.
//

import Foundation

enum Origin {
    case Gold, Rice, Iron, Ice, Fire, Light, Dark
    
    var name: String {
        switch self {
            
        case .Gold:
            return "金币"
        case .Rice:
            return "面包"
        case .Iron:
            return "钢铁"
        case .Ice:
            return "冰霜"
        case .Fire:
            return "火焰"
        case .Light:
            return "神圣"
        case .Dark:
            return "魔能"
        }
    }
    
    var imageName: String {
        switch self {
            
        case .Gold:
            return "bitcoinsign.circle.fill"
        case .Rice:
            return "frying.pan"
        case .Iron:
            return "id.factory.Iron"
        case .Ice:
            return "snowflake"
        case .Fire:
            return "flame"
        case .Light:
            return "sun.max"
        case .Dark:
            return "moon.stars"
        }
    }
}

enum Race {
    case Human, Dragon, Demon, Remote
}

enum DamageType {
    case Normal, Magic
}

enum StartingType {
    case None, NormalAttack, Timer
}

enum SkillType {
    case Static, Normal, Magic
}

struct Expend: Hashable {
    let origin: Origin
    let value: Int64
}

