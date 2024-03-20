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
    
    let guardian = GuardianClass()
    let dragon = DragonClass()
    let villagers = VillagersClass()
    
//    func herosList() -> [Hero] { [guardian, dragon, villagers] }
    
    var dragonHand: [Action] = []
    var guardianHand: [Action] = []
    var villagersHand: [Action] = []
    
    let villainsList: VillainsList = VillainsList(
        hugeVillains: [],
        bigVillains: [BigDragon()],
        littleVillains: [LittleDragon(), LittleDragon()])
        
    var delegate: battleManagerDelegate?
    
    //MARK: - Init
    
    init() {
        
        // Heros
        self.guardianHand = guardian.fetchNewHand(numberOfActions: 5)
        self.dragonHand = dragon.fetchNewHand(numberOfActions: 5)
        
        // Villains
        villainsList.formIntentions()
        
    }
    
    func setDelegate(_ delegate: battleManagerDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - Retrieve Data
    
    func retrieveHeroHands() -> [[Action]] {
        return [guardianHand, dragonHand]
    }
    
    func retrieveHeros() -> HerosClass {
        let herosList: HerosClass = HerosClass(guardian: guardian, villagers: villagers, dragon: dragon)
        return herosList
    }
    
    func retrieveVillains() -> VillainsList {
        villainsList
    }
    
    func retrieveEnergy(for hero: Hero) -> Int {
        let guardianEnergy = guardian.stats.energy
        let dragonEnergy = dragon.stats.energy
        let energyResponse = hero == .guardian ? guardianEnergy : (hero == .dragon ? dragonEnergy : 0)
        return energyResponse
    }

    //MARK: - Actions
    
    func actionPlayed(actionType: ActionType, hero: Hero, action actionNum: Int, targetVillain: TargetVillain?, targetHero: Hero?) {
        let thisHero = hero == .dragon ? dragon : (hero == .guardian ? guardian : villagers)
        let heroHand = hero == .dragon ? dragonHand : guardianHand
        let action = heroHand[actionNum]

        switch actionType {
        case .attack:
            if let villain = targetVillain {
                attackPlayed(hero: thisHero, action: action, villainAttacked: villain)
            }
        case .block:
            blockPlayed(hero: thisHero, action: action)
        case .protect:
            let protectedHero = targetHero == .dragon ? dragon : (targetHero == .guardian ? guardian : villagers)
            protectPlayed(protector: thisHero, protected: protectedHero, action: action)
        }
    }
    
    func attackPlayed(hero: HeroClass, action: Action, villainAttacked: TargetVillain) {
        print("attack played")
        
        // Properties
        let villain = villainAttacked.getVillainObject(from: villainsList)

        // Feedback
        print("hero: \(hero.stats.name)")
        print("action: \(action.name)")
        print("target: \(villain.stats.name)")
        
        // Cost
        if hero.stats.energy >= action.cost {
            // Attack
            action.attack(from: hero, to: villain)
            
            // updateUI
            delegate?.updateCharacters(herosList: retrieveHeros(), villainsList: self.villainsList)
        } else {
            print("not enough energy \(hero.stats.energy)")
        }

    }
    
    func blockPlayed(hero: HeroClass, action: Action) {
        
        // Feedback
        print("block played")
        print("hero: \(hero.stats.name)")
        print("action: \(action.name)")
        
        if hero.stats.energy >= action.cost {
            
            // Block
            action.block(character: hero)
            
            // updateUI
            delegate?.updateCharacters(herosList: retrieveHeros(), villainsList: self.villainsList)
        }
        
    }
    
    func protectPlayed(protector: HeroClass, protected: HeroClass, action: Action) {
        print("protect played")
        print("protector: \(protector.stats.name)")
        print("protected: \(protected.stats.name)")
        print("action: \(action.name)")
        
        if protector.stats.energy >= action.cost {
            
            // Protect
            action.protect(protector: protector, protected: protected)
            
            // updateUI
            delegate?.updateCharacters(herosList: retrieveHeros(), villainsList: self.villainsList)
        }
        
    }

    //MARK: - Take Turns
    
    func nextTurn() {
        // Villains
        let actionsCarriedOut = executeIntentions()
        resetVillainsForNextTurn()
        villainsList.formIntentions()

        // Heros
        resetHerosForNextTurn()
    }
    
    func executeIntentions() -> [VillainIntentions] {
        let actionsCarriedOut: [VillainIntentions] = villainsList.map { $0.currentStats().intent! }
        villainsList.forEach(smallestFirst: true) { $0.takeAction() }
        return actionsCarriedOut
    }
    
    
    func resetVillainsForNextTurn() {
    }
    
    func resetHerosForNextTurn() {
    }
    
}

//MARK: - Protocol: View Controller
protocol battleManagerDelegate {
    func updateCharacters(herosList: HerosClass, villainsList: VillainsList)
    func nextTurn(actionsCarriedOut: [VillainIntentions], updatedHerosList: HerosClass, updatedVillainsList: VillainsList)
}
