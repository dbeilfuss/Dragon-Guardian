//
//  basicBlock.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/13/24.
//

import Foundation

class BasicBlock: Action {
    
    var strength: Int
    let blockTip = "Drag block cards to yourself to block incoming attacks."
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(actionType: .block, level: level, name: name, cost: cost, description: description, attackStrength: nil, blockStrength: strength, tip: blockTip)
    }
    
    override func block(character: Character) {
        print("characterBlock: \(character.stats.block)")
        character.stats.energy -= cost
        character.stats.block += self.strength
        print("characterBlock: \(character.stats.block)")
    }
    
    
    
}
