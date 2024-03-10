//
//  CallsToAction.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class CallToAction: Action {
    
    var strength: Int
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(level: level, name: name, cost: cost, description: description, attackStrength: strength)
    }
    
//    override func action(on character: Character) {
//    }
    
}
