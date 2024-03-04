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
        baseLevel: 3,
        maxHealth: 20,
        health: 20,
        block: 0,
        statusEffects: [String()],
        actionsCount: 3, 
        deck: []
    )
    
    init() {
        super .init(startingStats: customStartingStats)
        deck = drawStartingDeck()

    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.punch, attacks.punch, attacks.punch, attacks.punch, attacks.punch, attacks.punch, attacks.punch, attacks.slash, attacks.slash, attacks.throwRock]
        return startingDeck
    }
    

    
}
