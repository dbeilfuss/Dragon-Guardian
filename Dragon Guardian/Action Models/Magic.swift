//
//  Magic.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Magic: Action {
    
    var strength: Int
    
    init(level: Int, name: String, cost: Int, description: String, strength: Int) {
        self.strength = strength
        super.init(level: level, name: name, cost: cost, description: description)
    }
    
//    override func action(on character: Character) {
//    }
    
}
