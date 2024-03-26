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
    let attacks = DragonAttacks()
    let blocks = DragonBlocks()
    let protects = DragonProtects()
    
    var startingStats = CharacterStats(
        name: "Dragon",
        hero: .dragon,
        level: 1,
        maxHealth: 50,
        health: 50,
        maxEnergy: 5,
        energy: 5,
        block: 0, 
        protection: ProtectionArray(protectionArray: []),
        protectionIDs: [],
        statusEffects: [String()],
        deck: [], 
        discardPile: []
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
    
    override func resetForNextTurn() {
        super.resetForNextTurn()
        
        
//    name: "Name",
//    hero: nil,
//    level: 1,
//    maxHealth: 10,
//    health: 10,
//    maxEnergy: 1,
//    energy: 1,
//    block: 0,
//    protection: ProtectionArray(protectionArray: []),
//    protectionIDs: [],
//    statusEffects: [],
//    intent: nil,
//    deck: [],
//    discardPile: []
    }
    
}
