//
//  Villagers.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/4/24.
//

import Foundation

class Villagers: Hero {
    let attacks = dragonAttacks()
    
    var customStartingStats = CharacterStats(
        name: "Villagers",
        level: 1,
        maxHealth: 10,
        health: 10,
        block: 0,
        statusEffects: [String()],
        actionsCount: 0,
        deck: []
    )
    
    init() {
        super .init(startingStats: customStartingStats)
        deck = drawStartingDeck()

    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.bite, attacks.bite, attacks.bite]
        return startingDeck
    }
    
}
