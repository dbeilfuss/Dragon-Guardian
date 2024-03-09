//
//  Dragon.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Dragon: Hero {
    let attacks = dragonAttacks()
    
    var startingStats = CharacterStats(
        name: "Dragon",
        level: 1,
        maxHealth: 30,
        health: 25,
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
        let startingDeck = [attacks.claw, attacks.claw,attacks.bite, attacks.bite, attacks.tailWhip]
        return startingDeck
    }
    
}
