//
//  Character.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Character {
    let name: String
    var health: Int
    var block: Int
    var statusEffects: [String]
    
    var deck: [Action] = [humanAttacks().punch]
    var drawPile: [Action?] = []
    var discardPile: [Action?] = []
    
    var startingStats = CharacterStats(
        name: "Default",
        baseLevel: 1,
        maxHealth: 10,
        health: 10,
        block: 0,
        statusEffects: [],
        actionsCount: 0,
        deck: [])
    
    init(startingStats: CharacterStats) {
        self.name = startingStats.name
        self.health = startingStats.health
        self.block = startingStats.block
        self.statusEffects = startingStats.statusEffects
        
        self.startingStats = startingStats
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
