//
//  Hero.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class HeroClass: Character {
    
    //MARK: - Properties
    var handSize = 3
    
    //MARK: - Actions
    
    func fetchNewHand(oldHand: [Action?]) -> [Action] {
        // Old Hand
        if oldHand.count > 0 {
            for action in oldHand {
                discardCard(action: action!)
            }
        }
        
        // New Hand
        var hand: [Action] = []
        
        for _ in 1...handSize {
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
    
    func discardCard(action: Action) {
        stats.discardPile.append(action)
    }
    
    //MARK: - Stats
    
    func heal(percentage: Double) {
        // Calculate
        var calculatedHealth = stats.health * Int(percentage * 100) / 100
        
        // Must not be larger than maxHealth
        if calculatedHealth > stats.maxHealth {
            calculatedHealth = stats.maxHealth
        }
        
        // Heal
        stats.health = calculatedHealth
        
    }

}
