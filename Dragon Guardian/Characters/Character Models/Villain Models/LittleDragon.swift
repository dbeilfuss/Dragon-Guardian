//
//  BadDragon.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class LittleDragon: Villain {
    
    let startingStats = CharacterStats(
        name: "Little Dragon",
        level: 1,
        maxHealth: 30,
        health: 30,
        maxEnergy: 0,
        energy: 0,
        block: 0,
        protection: ProtectionArray(protectionArray: []),
        protectionIDs: [],
        statusEffects: [String()],
        deck: [], 
        discardPile: []
    )
    
    required init () {
        super .init(startingStats: startingStats)
        stats.deck = drawStartingDeck()
    }
    
}
