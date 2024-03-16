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
        level: 1,
        maxHealth: 10,
        health: 10,
        maxEnergy: 1,
        energy: 1,
        block: 0,
        protection: [],
        protectionIDs: [],
        statusEffects: [],
        deck: []
    )
    
    var drawStack: [Action] = []
    var discardPile: [Action] = []
    
    var intent: String = "none"
    
    init(startingStats: CharacterStats) {
        self.stats = startingStats
    }
    
    func currentStats() -> CharacterStats {
        return stats
    }
    
    func fetchNewHand(numberOfActions: Int) -> [Action] {
        var hand: [Action] = []
        
        for _ in 1...numberOfActions {
            if drawStack.count == 0 {
                if discardPile.count == 0 {
                    drawStack = stats.deck.shuffled()
                } else {
                    shuffleDiscardPile()
                }
            }
            hand.append(drawCard(from: drawStack))
        }
        
        return hand
        
    }
    
    func shuffleDiscardPile() {
        drawStack = discardPile.shuffled()
        discardPile = []
    }
    
    func drawCard(from: [Action]) -> Action {
        var card: Action
        card = drawStack.remove(at: 0)
        return card
    }
    
    func drawRandomCard(from: [Action]) -> Action {
        var card: Action
        let randomInt = Int.random(in: 0...drawStack.count)
        
        card = drawStack[randomInt]
        drawStack.remove(at: randomInt)
        
        return card
    }
    
}
