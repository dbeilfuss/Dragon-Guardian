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
    
    var villainsList: VillainsObjects = VillainsObjects(hugeVillains: [],
        bigVillains: [BigDragon()],
        littleVillains: [LittleDragon(), LittleDragon()])
        
    var delegate: battleManagerDelegate?
    
    //MARK: - Init
    
    init() {
        
        // Heros
        self.guardianHand = guardian.fetchNewHand(numberOfActions: 5, oldHand: guardianHand)
        self.dragonHand = dragon.fetchNewHand(numberOfActions: 5, oldHand: dragonHand)
        
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
    
    func retrieveHeros() -> HerosList {
        let herosList: HerosList = HerosList(guardian: guardian, villagers: villagers, dragon: dragon)
        return herosList
    }
    
    func retrieveVillains() -> VillainsObjects {
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
                attackPlayed(heroType: hero, heroClass: thisHero, action: action, actionNum: actionNum, villainAttacked: villain)
            }
        case .block:
            blockPlayed(heroType: hero, heroClass: thisHero, action: action, actionNum: actionNum)
        case .protect:
            let protectedHero = targetHero == .dragon ? dragon : (targetHero == .guardian ? guardian : villagers)
            protectPlayed(heroType: hero, protector: thisHero, protected: protectedHero, action: action, actionNum: actionNum)
        }
        
        // Remove Dead Villain
        if let thisVillain = targetVillain?.getVillainObject(from: villainsList) {
            let villainIsDead = thisVillain.stats.health <= 0 ? true : false
            if villainIsDead {
                print("villain is Dead")
                print(villainsList)
                villainsList.removeVillain(target: targetVillain!)
                print(villainsList)
                
                delegate?.removeVillain(targetVillain!)
            }
        }
        
        // updateUI
        delegate?.updateCharacters(herosList: retrieveHeros(), villainsList: self.villainsList)
        
        
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

    //MARK: - Take Turns
    
    func nextTurn() {
        // Villains
        let intentions = villainsList.map { $0.currentStats().intent! }
        print("intentions: \(intentions)")
        executeIntentions()
        resetVillainsForNextTurn()
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
        dragonHand = herosList.dragon.fetchNewHand(numberOfActions: 5, oldHand: dragonHand)
        guardianHand = herosList.guardian.fetchNewHand(numberOfActions: 5, oldHand: guardianHand)
    }
    
}

//MARK: - Villain Actions
extension BattleManager: VillainBattleManager {
    func villainActionTaken(self thisVillain: Villain, intent: VillainIntention) {
        let targetHero: HeroClass = intent.targetHero == .dragon ? dragon : (intent.targetHero == .guardian ? guardian : villagers)
        let action = intent.action
        let targetVillain = intent.targetVillain
        
        switch action.actionType {
        case .attack:
            villainAttackPlayed(targetHero: targetHero, action: action, villain: thisVillain)
        case .block:
            villainBlockPlayed(self: thisVillain, action: action)
        case .protect:
            if let protectedVillain = targetVillain {
                villainProtectPlayed(protector: thisVillain, protected: protectedVillain, action: action)
            }
        }
    }
    
    func villainAttackPlayed(targetHero: HeroClass, action: Action, villain: Villain) {
        print("attack played")
        
        // Feedback
        print("villain: \(villain.stats.name)")
        print("action: \(action.name)")
        print("target: \(targetHero.stats.name)")

        
        // Attack
        action.attack(from: villain, to: targetHero)
        
    }
    
    func villainBlockPlayed(self villain: Villain, action: Action) {
        
        // Feedback
        print("block played")
        print("villain: \(villain.stats.name)")
        print("action: \(action.name)")
        
        // Block
        action.block(character: villain)
        
    }
    
    func villainProtectPlayed(protector: Villain, protected: TargetVillain, action: Action) {
        let protectedVillain = villainsList.getVillainObject(from: protected)
        
        print("protect played")
        print("protector: \(protector.stats.name)")
        print("protected: \(protectedVillain.stats.name)")
        print("action: \(action.name)")
        
        // Protect
        action.protect(protector: protector, protected: protectedVillain)
        
    }
}

//MARK: - Protocol: View Controller
protocol battleManagerDelegate {
    func updateCharacters(herosList: HerosList, villainsList: VillainsObjects)
    func nextTurn(actionsCarriedOut: [VillainIntention], updatedHerosList: HerosList, updatedVillainsList: VillainsObjects)
    func removeVillain(_: TargetVillain)
}
