//
//  Villagers.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/4/24.
//

import Foundation

class Villagers: Hero {
    let attacks = dragonAttacks()
    
    var startingStats = CharacterStats(
        name: "Villagers",
        level: 1,
        maxHealth: 10,
        health: 10,
        maxEnergy: 0,
        energy: 0,
        block: 0,
        statusEffects: [String()],
        deck: []
    )
    
    init() {
        super .init(startingStats: startingStats)
        stats.deck = drawStartingDeck()

    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.bite, attacks.bite, attacks.bite]
        return startingDeck
    }
    
}
