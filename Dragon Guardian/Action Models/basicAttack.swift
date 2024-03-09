//
//  Attack.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class basicAttack: Action {
    
    var strength: Int
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(level: level, name: name, cost: cost, description: description)
    }
    
    override func attack(from attacker: Character, to defender: Character) {
        print("defenderHealth: \(defender.stats.health)")
        attacker.stats.energy -= cost
        defender.stats.health -= self.strength
        print("defenderHealth: \(defender.stats.health)")
    }
    
}
