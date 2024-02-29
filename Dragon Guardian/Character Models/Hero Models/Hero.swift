//
//  Hero.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Hero: Character {
    var actionsRemaining: Int
    
    override init(startingStats: CharacterStats) {
        self.actionsRemaining = startingStats.actionsCount ?? 3
        super.init(startingStats: startingStats)
    }

}
