//
//  Guardian.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class GuardianClass: HeroClass {
    
    let attacks = guardianAttacks()
    let blocks = guardianBlock()
    
    let heroType: Hero = .guardian
    
    let startingStats = CharacterStats(
        name: "Guardian",
        level: 1,
        maxHealth: 20,
        health: 15,
        maxEnergy: 10,
        energy: 10,
        block: 0, 
        protection: [],
        protectingIDs: [],
        statusEffects: [String()],
        deck: []
    )
    
    init() {
        super .init(startingStats: startingStats)
        stats.deck = drawStartingDeck()
    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [
            attacks.punch, attacks.punch, attacks.punch, attacks.rock, attacks.rock, attacks.dagger,
            blocks.block, blocks.block, blocks.block, blocks.dodge, blocks.dodge, blocks.roll
        ]
        return startingDeck
    }
    

    
}
