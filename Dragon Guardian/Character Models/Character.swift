//
//  Character.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Character {
    let name: String
    var level: Int
    var maxHealth: Int
    var health: Int
    var block: Int = 0
    var statusEffects: [String]
    
    var deck: [Action] = [humanAttacks().punch]
    var drawPile: [Action?] = []
    var discardPile: [Action?] = []
    
    var intent: String = "none"
    
    var actionsRemaining: Int = 1
    
    var startingStats = CharacterStats(
        name: "Default",
        level: 2,
        maxHealth: 10,
        health: 10,
        block: 0,
        statusEffects: [],
        actionsCount: 0,
        deck: [])
    
    init(startingStats: CharacterStats) {
        self.name = startingStats.name
        self.level = startingStats.level
        self.maxHealth = startingStats.maxHealth
        self.health = startingStats.health
        self.block = startingStats.block
        self.statusEffects = startingStats.statusEffects
        self.deck = startingStats.deck
        
        self.startingStats = startingStats
    }
    
    func currentStats() -> CharacterStats {
        return CharacterStats(name: name, level: level, maxHealth: maxHealth, health: health, block: block, statusEffects: statusEffects, intent: intent, actionsCount: actionsRemaining, deck: deck)
    }
    
    func fetchNewHand(numberOfActions: Int) -> [Action] {
        var hand: [Action] = []
        
        for _ in 1...numberOfActions {
            hand.append(drawCardFromDeck())
        }
        
        return hand
        
    }
    
    func drawCardFromDeck() -> Action {
        
        var card: Action
        
        if drawPile.count == 0 {
            if discardPile.count > 0 {
                deck = discardPile.shuffled() as! [Action]
            }
        }
        
        let randomInt = Int.random(in: 0...drawPile.count)
        card = deck[randomInt]
        deck.remove(at: randomInt)
        
        return card
    }
    
}
