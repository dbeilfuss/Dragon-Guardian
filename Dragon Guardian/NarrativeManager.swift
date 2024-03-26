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
    var gameState: GameState = .inProgress
    
    mutating func newRound(oldHerosList: HerosList?) -> RoundSetup {
        gameState = .inProgress
        currentRoundNum += 1
        currentRoundSetup = RoundSetup(
            environment: chooseEnvironment(),
            villains: chooseVillains(),
            heros: configureHeros(oldHerosList: oldHerosList))
        return currentRoundSetup!
    }
    
    func chooseEnvironment() -> String {
        if (currentRoundNum / 3) % 2 == 0 {
            return Environment.forest.rawValue
        } else {
            return Environment.desert.rawValue
        }
    }
        
    func chooseVillains() -> VillainsObjects {
        let villainsList = VillainsList()
        
        let villainRounds: [VillainRound] = [
            VillainRound(hugeVillains: 0, bigVillains: 0, littlVillains: 1),
            VillainRound(hugeVillains: 0, bigVillains: 0, littlVillains: 2),
            VillainRound(hugeVillains: 0, bigVillains: 1, littlVillains: 0),
            VillainRound(hugeVillains: 0, bigVillains: 0, littlVillains: 3),
            VillainRound(hugeVillains: 0, bigVillains: 1, littlVillains: 2),
            VillainRound(hugeVillains: 1, bigVillains: 0, littlVillains: 0)
            ]
        
        let villains = villainsList.getVillains(for: villainRounds[currentRoundNum - 1])
        
        return villains
    }
    
    func configureHeros(oldHerosList: HerosList?) -> HerosList {
        var heros = HerosList(
            guardian: GuardianClass(),
            villagers: VillagersClass(),
            dragon: DragonClass()
        )
        
        if oldHerosList != nil {
            heros = oldHerosList!
        }
        
        // Level
        var heroLevel = 1
        if currentRoundNum <= 2 {
            heroLevel = 1
        } else if currentRoundNum <= 4 {
            heroLevel = 2
        } else {
            heroLevel = 3
        }
        
        // Health
//        let healthMultiplier = 1.1
        
        // Energy
        let baseEnergy = 1
        let updatedEnergy = baseEnergy + heroLevel - 1
        
        // Deck & Hand
        var guardianDeck: [Action] = []
        for i in 1...heroLevel {
            let nextLevelCards = getHeroDeck(heroLevel: i, hero: .guardian)
            guardianDeck = guardianDeck + nextLevelCards
        }
        heros.guardian.stats.deck = guardianDeck
        
        var dragonDeck: [Action] = []
        for i in 1...heroLevel {
            let nextLevelCards = getHeroDeck(heroLevel: i, hero: .dragon)
            dragonDeck = dragonDeck + nextLevelCards
        }
        heros.dragon.stats.deck = dragonDeck
        
        let baseHandSize = 3
        var updatedHandSize = baseHandSize + heroLevel - 1
        
        // Configure
        heros.forEach {
            $0.stats.level = heroLevel
//            $0.stats.maxHealth = $0.stats.maxHealth * Int(healthMultiplier * 100) / 100
//            $0.stats.health = $0.stats.maxHealth
            $0.stats.maxEnergy = updatedEnergy
            $0.stats.energy = updatedEnergy
            $0.handSize = updatedHandSize
        }
        
        // Villagers

        
        return heros
    }
    
    func getHeroDeck(heroLevel: Int, hero: Hero) -> [Action] {
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
    
    func getRoundNumber() -> Int {
        return currentRoundNum
    }
    
    //MARK: - Next Round
    
    mutating func declareVictory() {
        gameState = .victory
    }
    
}
