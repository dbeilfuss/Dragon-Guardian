//
//  Villagers.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/4/24.
//

import Foundation

class VillagersClass: HeroClass {
    let attacks = DragonAttacks()
    let heroType: Hero = .villagers
    
    var startingStats = CharacterStats(
        name: "Villagers",
        hero: .villagers,
        level: 1,
        maxHealth: 50,
        health: 50,
        maxEnergy: 0,
        energy: 0,
        block: 0,
        protection: ProtectionArray(protectionArray: []),
        protectionIDs: [],
        statusEffects: [String()],
        deck: [],
        discardPile: []
    )
    
    init() {
        super .init(startingStats: startingStats)
        stats.deck = drawStartingDeck()

    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = [attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.claw, attacks.bite, attacks.bite, attacks.bite]
        return startingDeck
    }
    
}
