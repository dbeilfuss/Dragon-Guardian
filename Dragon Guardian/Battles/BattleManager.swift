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
    var delegate: battleManagerDelegate?
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
    
    func setDelegate(_ delegate: battleManagerDelegate) {
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
    
    

    //MARK: - Actions
    
    func actionPlayed(actionType: ActionType, hero: Hero, action actionNum: Int, targetVillain: TargetVillain?, targetHero: Hero?) {
        let thisHero = herosList.getHero(hero: hero)
        let heroHand = hero == .dragon ? dragonHand : guardianHand
        let action = heroHand[actionNum]

        switch actionType {
        case .attack:
            if let villain = targetVillain {
                attackPlayed(heroType: hero, heroClass: thisHero, action: action, actionNum: actionNum, villainAttacked: villain)
            }
        case .block:
            blockPlayed(heroType: hero, heroClass: thisHero, action: action, actionNum: actionNum)
        case .protect:
            let protectedHero = herosList.getHero(hero: targetHero!)
            protectPlayed(heroType: hero, protector: thisHero, protected: protectedHero, action: action, actionNum: actionNum)
        }
        
        // Remove Dead Villain
        if let thisVillain = targetVillain?.getVillainObject(from: villainsList) {
            let villainIsDead = thisVillain.stats.health <= 0 ? true : false
            if villainIsDead {
                print("villain is Dead")
                
                // Protection
                if thisVillain.stats.protectionIDs.count > 0 {
                    for id in thisVillain.stats.protectionIDs {
                        villainsList.removeProtection(protectionID: id)
                    }
                }
                
                // VillainsList
                villainsList.removeVillain(target: targetVillain!)
                
                // UI
                delegate?.removeVillain(targetVillain!)
                delegate?.updateCharacters(herosList: herosList, villainsList: villainsList)
            }
        }

        // updateUI
        delegate?.updateCharacters(herosList: retrieveHeros(), villainsList: self.villainsList)
        
        // Victory & Defeat
        checkForVictory()
        
    }
    
    func attackPlayed(heroType: Hero, heroClass: HeroClass, action: Action, actionNum: Int, villainAttacked: TargetVillain) {
        print("attack played")
        
        // Properties
        let villain = villainAttacked.getVillainObject(from: villainsList)

        // Feedback
        print("hero: \(heroClass.stats.name)")
        print("action: \(action.name)")
        print("target: \(villain.stats.name)")
        
        // Cost
        if heroClass.stats.energy >= action.cost {
            // Attack
            action.attack(from: heroClass, to: villain)
            
            // DiscardAction
            discardAction(hero: heroType, heroClass: heroClass, action: action, actionNum: actionNum)
        } else {
            print("not enough energy \(heroClass.stats.energy)")
        }

    }
    
    func blockPlayed(heroType: Hero, heroClass: HeroClass, action: Action, actionNum: Int) {
        
        // Feedback
        print("block played")
        print("hero: \(heroClass.stats.name)")
        print("action: \(action.name)")
        
        if heroClass.stats.energy >= action.cost {
            
            // Block
            action.block(character: heroClass)
            
            // DiscardAction
            discardAction(hero: heroType, heroClass: heroClass, action: action, actionNum: actionNum)

        }
        
    }
    
    func protectPlayed(heroType: Hero, protector: HeroClass, protected: HeroClass, action: Action, actionNum: Int) {
        print("protect played")
        print("protector: \(protector.stats.name)")
        print("protected: \(protected.stats.name)")
        print("action: \(action.name)")
        
        if protector.stats.energy >= action.cost {
            
            // Protect
            action.protect(protector: protector, protected: protected)
            
            // DiscardAction
            discardAction(hero: heroType, heroClass: protector, action: action, actionNum: actionNum)

        }
        
    }
    
    func discardAction(hero: Hero, heroClass: HeroClass, action: Action, actionNum: Int) {
        switch hero {
        case .guardian:
            guardianHand.remove(at: actionNum)
        case .dragon:
            dragonHand.remove(at: actionNum)
        case .villagers:
            print("no villager hand to discard from")
        }
        
        heroClass.discardCard(action: action)
        
    }
    
    //MARK: - Victory & Defeat
    
    func checkForVictory() {
        
        if villainsList.count() == 0 {
            gameState = .victory
        }
        
        if gameState == .victory {
            narrativeManager.declareVictory()
            delegate?.declareVictory()
        }
        
    }
    
    func loadNextRound() {
        initializeGameData()
        delegate?.updateForNewRound()
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
protocol battleManagerDelegate {
    func updateCharacters(herosList: HerosList, villainsList: VillainsObjects)
    func nextTurn(actionsCarriedOut: [VillainIntention], updatedHerosList: HerosList, updatedVillainsList: VillainsObjects)
    func removeVillain(_: TargetVillain)
    func declareVictory()
    func updateForNewRound()
}
