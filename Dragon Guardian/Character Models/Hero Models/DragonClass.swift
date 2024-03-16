//
//  Dragon.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class DragonClass: HeroClass {
    
    let heroType: Hero = .dragon
    
    // Actions
    let attacks = dragonAttacks()
    let blocks = dragonBlocks()
    let protects = dragonProtects()
    
    var startingStats = CharacterStats(
        name: "Dragon",
        level: 1,
        maxHealth: 30,
        health: 25,
        maxEnergy: 10,
        energy: 10,
        block: 0, 
        protection: [],
        protectionIDs: [],
        statusEffects: [String()],
        deck: []
    )
    
    init() {
        super .init(startingStats: startingStats)
        stats.deck = drawStartingDeck()
    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [
            attacks.claw, attacks.claw, attacks.claw, attacks.tailWhip, attacks.tailWhip, attacks.bite,
            blocks.growl, blocks.growl, blocks.growl, blocks.anticipate, blocks.anticipate, blocks.cocoon,
            protects.pact, protects.shield, protects.sacrifice
        ]
        return startingDeck
    }
    
}
