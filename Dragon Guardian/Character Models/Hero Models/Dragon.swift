//
//  Dragon.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Dragon: Hero {
    let attacks = dragonAttacks()
    
    var customStartingStats = CharacterStats(
        name: "Dragon",
        level: 2,
        maxHealth: 30,
        health: 25,
        block: 0,
        statusEffects: [String()],
        actionsCount: 2, 
        deck: []
    )
    
    init() {
        super .init(startingStats: customStartingStats)
        deck = drawStartingDeck()

    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.claw, attacks.claw,attacks.bite, attacks.bite, attacks.tailWhip]
        return startingDeck
    }
    
}
