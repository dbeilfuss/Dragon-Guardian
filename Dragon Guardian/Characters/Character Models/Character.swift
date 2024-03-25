//
//  Character.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Character {
    var stats: CharacterStats = CharacterStats(
        name: "Name",
        hero: nil,
        level: 1,
        maxHealth: 10,
        health: 10,
        maxEnergy: 1,
        energy: 1,
        block: 0,
        protection: ProtectionArray(protectionArray: []),
        protectionIDs: [],
        statusEffects: [],
        intent: nil,
        deck: [],
        discardPile: []
    )
    
    init(startingStats: CharacterStats) {
        self.stats = startingStats
    }
    
    func currentStats() -> CharacterStats {
        return stats
    }
    
    func resetForNextTurn() {
        stats.energy = stats.maxEnergy
        stats.block = 0
        stats.protection = ProtectionArray(protectionArray: [])
        stats.protectionIDs = []
        stats.statusEffects = []
    }
    
}
