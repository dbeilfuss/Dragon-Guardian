//
//  NarrativeManager.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/23/24.
//

import Foundation

struct NarrativeManager {
    
    var currentRoundNum = 0
    var currentRoundSetup: RoundSetup?
    
    mutating func newRound() -> RoundSetup {
        currentRoundNum = 1
        currentRoundSetup = RoundSetup(
            environment: chooseEnvironment(),
            villains: chooseVillains(),
            heros: configureHeros())
        return currentRoundSetup!
    }
    
    func chooseEnvironment() -> String {
        let environments = ["Desert", "Forest"]
        
        if (currentRoundNum / 3) % 2 == 0 {
            return environments[1]
        } else {
            return environments[0]
        }
        
//        let environment: String = environments.randomElement()!
//        return environment
    }
        
    func chooseVillains() -> VillainsObjects {
        let villains = VillainsObjects(hugeVillains: [],
                                       bigVillains: [BigDragon()],
                                       littleVillains: [LittleDragon(), LittleDragon()])
        return villains
    }
    
    func configureHeros() -> HerosList {
        let heros = HerosList(
            guardian: GuardianClass(),
            villagers: VillagersClass(),
            dragon: DragonClass()
        )
        
        // Level
        var heroLevel = 1
        if currentRoundNum <= 6 {
            heroLevel = 1
        } else if currentRoundNum <= 12 {
            heroLevel = 2
        } else {
            heroLevel = 3
        }
        
        // Health
        let healthMultiplier = 1.1
        
        // Energy
        let baseEnergy = 3
        
        // Hand
        let guardianDeck = getDeck(heroLevel: heroLevel, hero: .guardian)
        heros.guardian.stats.deck = guardianDeck
        
        let dragonDeck = getDeck(heroLevel: heroLevel, hero: .dragon)
        heros.dragon.stats.deck = dragonDeck

        // Configure
        heros.forEach {
            $0.stats.level = heroLevel
            $0.stats.maxHealth = $0.stats.maxHealth * Int(healthMultiplier * 100) / 100
            $0.stats.health = $0.stats.maxHealth
            $0.stats.energy = baseEnergy + heroLevel - 1
        }
        
        // Villagers
        
        
        
        
        return heros
    }
    
    func getDeck(heroLevel: Int, hero: Hero) -> [Action] {
        // Properties
        let guardianActions = GuardianActions()
        let availableGuardianActions = guardianActions.getActions(heroLevel: heroLevel)
        
        let dragonActions = DragonActions()
        let availableDragonActions = dragonActions.getActions(heroLevel: heroLevel)

        let deckSetup = DeckSetup(
            attacksLev1: 3,
            blocksLev1: 3,
            protectsLev1: 2,
            
            attacksLev2: 2,
            blocksLev2: 2,
            protectsLev2: 1,
            
            attacksLev3: 1,
            blocksLev3: 1,
            protectsLev3: 1
        )
        
        let theseActions = hero == .guardian ? availableGuardianActions : availableDragonActions
        
        let deck = deckSetup.createDeck(heroLevel: heroLevel, actions: theseActions)
        
        return deck
        
    }
    
}
