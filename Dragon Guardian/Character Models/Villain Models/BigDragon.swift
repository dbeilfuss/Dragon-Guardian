//
//  BigDragon.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/1/24.
//

import Foundation

class BigDragon: Villain {
    
    let attacks = dragonAttacks()
    
    let startingStats = CharacterStats(
        name: "Big Dragon",
        level: 3,
        maxHealth: 75,
        health: 75,
        maxEnergy: 1,
        energy: 1,
        block: 0,
        protection: [],
        protectionIDs: [],
        statusEffects: [String()],
        deck: []
    )
    
    init () {
        super .init(startingStats: startingStats)
        stats.deck = drawStartingDeck()
    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.bite, attacks.bite, attacks.bite]
        return startingDeck
    }
    
}
