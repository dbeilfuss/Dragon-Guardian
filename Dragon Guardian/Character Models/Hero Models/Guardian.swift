//
//  Guardian.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Guardian: Hero {
    
    let attacks = humanAttacks()
    
    let customStartingStats = CharacterStats(
        name: "Guardian",
        level: 3,
        maxHealth: 20,
        health: 15,
        block: 0,
        statusEffects: [String()],
        actionsCount: 3, 
        deck: []
    )
    
    init() {
        super .init(startingStats: customStartingStats)
        deck = drawStartingDeck()
        print(deck)
    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.punch, attacks.punch, attacks.dagger, attacks.dagger, attacks.rock]
        return startingDeck
    }
    

    
}
