//
//  Magic.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Magic: Action {
    
    var strength: Int
    let magicTip = ""
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(actionType: .attack, level: level, name: name, cost: cost, description: description, attackStrength: strength, blockStrength: nil, tip: magicTip)
    }
    
//    override func action(on character: Character) {
//    }
    
}
