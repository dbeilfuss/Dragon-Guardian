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
        baseLevel: 1,
        maxHealth: 30,
        health: 30,
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
