//
//  BigDragon.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/1/24.
//

import Foundation

class BigDragon: Villain {
    
    let attacks = dragonAttacks()
    
    let customStartingStats = CharacterStats(
        name: "Big Dragon",
        level: 3,
        maxHealth: 75,
        health: 55,
        block: 0,
        statusEffects: [String()],
        actionsCount: nil,
        deck: []
    )
    
    init () {
        super .init(startingStats: customStartingStats)
        deck = drawStartingDeck()
    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.bite, attacks.bite, attacks.bite]
        return startingDeck
    }
    
}
