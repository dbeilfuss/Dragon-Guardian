//
//  Villain.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Villain: Character {
    let baseLevel: Int
    
    override init(startingStats: CharacterStats) {
        self.baseLevel = startingStats.baseLevel ?? 1
        super.init(startingStats: startingStats)
    }
    
    func takeAction() {
        
    }
    
}
