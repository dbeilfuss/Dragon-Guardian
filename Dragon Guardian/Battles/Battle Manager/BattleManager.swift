//
//  GameManager.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation
import UIKit


class BattleManager: battleViewControllerDelegate {
    
    //MARK: - Properties
    
    var narrativeManager = NarrativeManager()
    var delegate: battleManagerUIDelegate?
    var gameState: GameState = .initializing
    
    // Heros
    var herosList: HerosList = HerosList(
        guardian: GuardianClass(),
        villagers: VillagersClass(),
        dragon: DragonClass()
    )
    var dragonHand: [Action] = []
    var guardianHand: [Action] = []
    
    // Villains
    var villainsList: VillainsObjects = VillainsObjects(hugeVillains: [HugeDragon()],
        bigVillains: [],
        littleVillains: [LittleDragon()])
        
    
    //MARK: - Init
    
    init() {
        initializeGameData()
    }
    
    func initializeGameData() {
        var oldHerosList = gameState == .initializing ? nil : herosList
        
        let roundSetup = narrativeManager.newRound(oldHerosList: oldHerosList)
        herosList = roundSetup.heros
        villainsList = roundSetup.villains
        
        // Heros
        self.guardianHand = herosList.guardian.fetchNewHand(oldHand: guardianHand)
        self.dragonHand = herosList.dragon.fetchNewHand(oldHand: dragonHand)
        
        // Villains
        villainsList.formIntentions()
        
        // Game State
        gameState = .inProgress
    }
    
    func setDelegate(_ delegate: battleManagerUIDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - Retrieve Data
    
    func retrieveEnvironment() -> String? {
        if let environment = narrativeManager.currentRoundSetup?.environment {
            return environment
        }
        
        return nil
    }
    
    func retrieveHeroHands() -> [[Action]] {
        return [guardianHand, dragonHand]
    }
    
    func retrieveHeros() -> HerosList {
        return herosList
    }
    
    func retrieveVillains() -> VillainsObjects {
        villainsList
    }
    
    func retrieveEnergy(for hero: Hero) -> Int {
        let guardianEnergy = herosList.guardian.stats.energy
        let dragonEnergy = herosList.dragon.stats.energy
        let energyResponse = hero == .guardian ? guardianEnergy : (hero == .dragon ? dragonEnergy : 0)
        return energyResponse
    }
    
    func retrieveAction(hero: Hero, action: Int) -> Action {
        let hand = hero == .dragon ? dragonHand : guardianHand
        let action = hand[action]
        return action
    }
    
    func getGamestate() -> GameState {
        return gameState
    }
    
    func getVillagerCount() -> Int {
        return herosList.villagers.stats.health
    }
    
    func getRoundNumber() -> Int {
        narrativeManager.currentRoundNum
    }

    //MARK: - Take Turns
    
    func nextTurn() {
        // Villains
        let intentions = villainsList.map { $0.currentStats().intent! }
        print("intentions: \(intentions)")
        resetVillainsForNextTurn()
        executeIntentions()
        villainsList.formIntentions()

        // Heros
        resetHerosForNextTurn()
        delegate?.updateCharacters(herosList: retrieveHeros(), villainsList: villainsList)
        
    }
    
    func executeIntentions(){
        villainsList.forEach(smallestFirst: true) { $0.takeAction(battleManager: self) }
    }
    
    
    func resetVillainsForNextTurn() {
        villainsList.forEach(smallestFirst: false) { $0.resetForNextTurn() }
    }
    
    func resetHerosForNextTurn() {
        let herosList = retrieveHeros()
        herosList.forEach { $0.resetForNextTurn() }
        dragonHand = herosList.dragon.fetchNewHand(oldHand: dragonHand)
        guardianHand = herosList.guardian.fetchNewHand(oldHand: guardianHand)
    }
    
}

//MARK: - Protocol: battleManagerDelegate
protocol battleManagerUIDelegate {
    func updateCharacters(herosList: HerosList, villainsList: VillainsObjects)
    func nextTurn(actionsCarriedOut: [VillainIntention], updatedHerosList: HerosList, updatedVillainsList: VillainsObjects)
    func removeVillain(_: TargetVillain)
    func declareVictory()
    func declareDefeat()
    func updateForNewRound()
}
