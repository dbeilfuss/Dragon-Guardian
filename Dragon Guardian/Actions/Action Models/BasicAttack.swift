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
        super.init(actionType: .attack, level: level, name: name, cost: cost, description: description, attackStrength: strength, blockStrength: nil)
    }
    
    override func attack(from attacker: Character, to target: Character) {
        print("targetHealth: \(target.stats.health)")
        attacker.stats.energy -= cost

        // Block
        let block = target.stats.block
        if block > strength {
            target.stats.block -= strength
        } else {
            strength -= block
            target.stats.block = 0
            
            // Protect
            strength = target.stats.protection.dealDamage(of: strength)
        }
        
        target.stats.health -= strength
        print("targetHealth: \(target.stats.health)")
    }
    
}
