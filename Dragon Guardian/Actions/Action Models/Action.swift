//
//  Action.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Action {
    let actionType: ActionType
    var level: Int
    let name: String
    var cost: Int
    let description: String
    var attackStrength: Int?
    var blockStrength: Int?
    var tip: String
    
    init(actionType: ActionType, level: Int, name: String, cost: Int, description: String, attackStrength: Int?, blockStrength: Int?, tip: String) {
        self.actionType = actionType
        self.level = level
        self.name = name
        self.cost = cost
        self.description = description
        self.attackStrength = attackStrength
        self.blockStrength = blockStrength
        self.tip = tip
    }
    
    func attack(from attacker: Character, to target: Character) {
        
    }
    
    func block(character: Character) {
        
    }
    
    func protect(protector: Character, protected: Character) {
        
    }
    
}
