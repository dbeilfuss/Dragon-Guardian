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
    
    func fetchNewHand(numberOfActions: Int) -> [Action] {
        var hand: [Action] = []
        
        for _ in 1...numberOfActions {
            if stats.deck.count == 0 {
                shuffleDiscardPile()
            }
            hand.append(drawRandomCard(from: stats.deck))
        }
        
        return hand
        
    }
    
    func shuffleDiscardPile() {
        if stats.discardPile.count > 0 {
            stats.deck = stats.discardPile.shuffled() as! [Action]
            stats.discardPile = []
        }
    }
    
    func drawNextCard(from: [Action]) -> Action {
        var card: Action
        card = stats.deck.remove(at: 0)
        return card
    }
    
    func drawRandomCard(from options: [Action]) -> Action {
        var card: Action
        let randomInt = Int.random(in: 0...options.count-1)
        
        card = stats.deck.remove(at: randomInt)
        
        return card
    }
    
    func resetForNextTurn() {
        
        stats.energy = stats.maxEnergy
        stats.block = 0
        stats.protection = ProtectionArray(protectionArray: [])
        stats.protectionIDs = []
        stats.statusEffects = []
        
        
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
