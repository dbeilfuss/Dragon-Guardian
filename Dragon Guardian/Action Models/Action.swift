//
//  Action.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Action {
    var level: Int
    let name: String
    var cost: Int
    let description: String
    
    init(level: Int, name: String, cost: Int, description: String) {
        self.level = level
        self.name = name
        self.cost = cost
        self.description = description
    }
    
    func attack(from attacker: Character, to defender: Character) {
    }
    
}
