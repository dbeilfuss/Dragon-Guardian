//
//  Protection.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/16/24.
//

import Foundation

struct Protection {
    var strength: Int
    let protector: Character
    let id: Int
    
    mutating func dealDamage(of attackDamage: Int) -> Int {
        
        // Properties
        var remainingDamage = attackDamage
        
        // Protected
        var protectorDamage = 0
        if strength > attackDamage {
            strength -= attackDamage
            protectorDamage = attackDamage / 2
            remainingDamage = 0
        } else {
            protectorDamage = strength / 2
            remainingDamage -= strength
            strength = 0
        }
        
        
        // Protector
        let startingHealth = protector.stats.health

        if startingHealth > protectorDamage {
            protector.stats.health -= protectorDamage
        } else {
            protector.stats.health = 0
        }
        protector.stats.protectionIDs.removeAll { $0 == id }

        
        return remainingDamage
    }
}

struct ProtectionArray {
    var protectionArray: [Protection]
    
    func sumOfProtection() -> Int {
        var totalProtection = 0
        for protection in protectionArray {
            totalProtection += protection.strength
        }
        return totalProtection
    }
    
    mutating func dealDamage(of damage: Int) -> Int {
        var remainingDamage = damage
        for i in protectionArray.indices {
            if remainingDamage > 0 {
                remainingDamage = protectionArray[i].dealDamage(of: remainingDamage)
            }
        }
        
        protectionArray.removeAll { $0.strength == 0 }
        
        return remainingDamage
    }
    
    mutating func removeProtection(protectionID: Int) {
        if protectionArray.count > 0 {
            print("checking for protection id: \(protectionID)")
            for i in 0...protectionArray.count - 1 {
                let protection = protectionArray[i]
                if protection.id == protectionID {
                    print("protection id found, removing")
                    
                    // Remove Protector's ID
                    let protector: Character = protection.protector
                        protector.stats.protectionIDs.removeAll(where: {$0 == protectionID})
                    
                    // Remove Protection from Protected
                    protectionArray.remove(at: i)
                    
                    
                }
            }
        }
    }
}
