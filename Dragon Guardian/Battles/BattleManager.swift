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
        formIntents()
        
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
    
    func retrieveVillains() -> VillainsList {
        villainsList
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

    //MARK: - Villain Actions
    
    func formIntents() {
        let allVillainLists: [[Villain]] = [villainsList.hugeVillains, villainsList.bigVillains, villainsList.littleVillains]
        for x in 0...allVillainLists.count - 1 {
            if allVillainLists[x].count > 0 {
                for i in 0...allVillainLists[x].count - 1 {
                    let villainSelf = TargetVillain(villainRow: x, villainNumber: i, villainView: nil)
                    allVillainLists[x][i].formIntent(villainsList: villainsList, villainSelf: villainSelf)
                }
            }
        }
    }
}

//MARK: - Protocol: View Controller
protocol battleManagerDelegate {
    func updateCharacters(herosList: HerosList, villainsList: VillainsList)
}
