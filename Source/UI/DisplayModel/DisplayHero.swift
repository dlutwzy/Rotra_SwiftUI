//
//  DisplayHero.swift
//  Rotra
//
//  Created by wzy on 2024/3/13.
//

import Foundation

import SwiftUI

class DisplayHero: ObservableObject {
    
    weak var hero: Hero?
    
    init(hero: Hero) {
        self.hero = hero
    }
}

extension DisplayHero: Identifiable {
    var id: String {
        hero?.identifier ?? ""
    }
}
