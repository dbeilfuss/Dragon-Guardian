//
//  BasicProtect.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/14/24.
//

import Foundation

class BasicProtect: Action {
    
    var strength: Int
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(actionType: .protect, level: level, name: name, cost: cost, description: description, attackStrength: nil, blockStrength: strength)
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
        
        print("with a strength of: \(strength)")
    }
    
}
