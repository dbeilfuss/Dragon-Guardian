//
//  Guardian.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Guardian: Hero {
    
    let attacks = guardianAttacks()
    
    let startingStats = CharacterStats(
        name: "Guardian",
        level: 1,
        maxHealth: 20,
        health: 15,
        maxEnergy: 10,
        energy: 10,
        block: 0,
        statusEffects: [String()],
        deck: []
    )
    
    init() {
        super .init(startingStats: startingStats)
        stats.deck = drawStartingDeck()
    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.punch, attacks.punch, attacks.dagger, attacks.dagger, attacks.rock]
        return startingDeck
    }
    

    
}
