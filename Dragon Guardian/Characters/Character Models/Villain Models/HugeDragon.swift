//
//  HugeDragon.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/24/24.
//

import Foundation

class HugeDragon: Villain {
    
    let attacks = DragonAttacks()
    let protects = DragonProtects()
    
    let startingStats = CharacterStats(
        name: "Huge Dragon",
        level: 3,
        maxHealth: 200,
        health: 200,
        maxEnergy: 1,
        energy: 1,
        block: 0,
        protection: ProtectionArray(protectionArray: []),
        protectionIDs: [],
        statusEffects: [String()],
        deck: [],
        discardPile: []
    )
    
    init () {
        super .init(startingStats: startingStats)
        stats.deck = drawStartingDeck()
    }
    
    override func drawStartingDeck() -> [Action] {
        let startingDeck = super.drawStartingDeck()
        
        let filteredDeck = startingDeck.filter { $0.level >= stats.level - 1}
        
        return filteredDeck
    }
    
}
