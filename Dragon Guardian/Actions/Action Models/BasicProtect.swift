//
//  BasicProtect.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/14/24.
//

import Foundation

class BasicProtect: Action {
    
    var strength: Int
    let protectTip = "Drag protect cards to allies to protect them.  You will take damage of 50% the blocked damage."
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(actionType: .protect, level: level, name: name, cost: cost, description: description, attackStrength: nil, blockStrength: strength, tip: protectTip)
    }
    
    override func protect(protector: Character, protected: Character) {
        print("Protector: \(protector)")
        print("Protected: \(protected)")

        // Cost
        protector.stats.energy -= cost
        
        // Add Protection
        let protectionID = Int.random(in: 1...1000)
        let protection = Protection(strength: strength, protector: protector, id: protectionID)
        protected.stats.protection.protectionArray.append(protection)
        protector.stats.protectionIDs.append(protectionID)
        
        // Remove Protection if Protecting Self
        if protector.stats.protection.protectionArray.first?.id == protectionID {
            print("protectorIsAlsoTarget, removing protection")
            protected.stats.protection.protectionArray[0].strength = 0
            protector.stats.protectionIDs.remove(at: 0)
        } else {
            print("with a strength of: \(strength)")
        }
    }
    
}
