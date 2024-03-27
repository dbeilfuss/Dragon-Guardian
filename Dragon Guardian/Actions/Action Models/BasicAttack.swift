//
//  Attack.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class BasicAttack: Action {
    
    let strength: Int
    let attackTip = "Drag attack cards to enemies to attack them."
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(actionType: .attack, level: level, name: name, cost: cost, description: description, attackStrength: strength, blockStrength: nil, tip: attackTip)
    }
    
    override func attack(from attacker: Character, to target: Character) {
        var strength = self.strength
        print("targetHealth: \(target.stats.health)")
        attacker.stats.energy -= cost

        // Block
        let block = target.stats.block
        print("strength: \(strength)")
        print("block: \(block)")
        if block > strength {
            target.stats.block -= strength
        } else {
            strength -= block
            target.stats.block = 0
            print("block: \(block)")
            print("strength: \(strength)")

            
            // Protect
            print("protect: \(target.stats.protection.sumOfProtection())")
            
            // Verify not protecting self
            let protector = target.stats.protection.protectionArray.first?.protector
            var protectorIsAlsoTarget = false
            if target.stats.protection.protectionArray.first?.id == protector?.stats.protection.protectionArray.first?.id {
                protectorIsAlsoTarget = true
                print("protectorIsAlsoTarget, bypassing protection")
            }
            
            if !protectorIsAlsoTarget {
                strength = target.stats.protection.dealDamage(of: strength)
                print("protect: \(target.stats.protection.sumOfProtection())")
                print("strength: \(strength)")
            }


        }
        
        target.stats.health -= strength
        print("targetHealth: \(target.stats.health)")
    }
    
}
