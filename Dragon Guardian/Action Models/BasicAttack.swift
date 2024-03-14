//
//  Attack.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class BasicAttack: Action {
    
    var strength: Int
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(actionType: .attack, level: level, name: name, cost: cost, description: description, attackStrength: strength, defenseStrength: nil)
    }
    
    override func attack(from attacker: Character, to defender: Character) {
        print("defenderHealth: \(defender.stats.health)")
        attacker.stats.energy -= cost
        defender.stats.health -= (self.strength - defender.stats.block)
        print("defenderHealth: \(defender.stats.health)")
    }
    
}
