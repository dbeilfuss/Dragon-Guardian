//
//  Attack.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Attack: Action {
    
    var strength: Int
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(level: level, name: name, cost: cost, description: description)
    }
    
    override func action(on character: Character) {
        character.health -= self.strength
    }
    
}

class GroupAttack: Action {
    
    var strength: Int
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(level: level, name: name, cost: cost, description: description)
    }
    
    override func action(on characters: [Character]) {
        let averageDamage: Int = strength / characters.count
        for character in characters {
            character.health -= averageDamage
        }
    }
    
}
