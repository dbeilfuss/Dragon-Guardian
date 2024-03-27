//
//  Extension - Actions.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/26/24.
//

import Foundation

//MARK: - Actions

extension BattleManager {
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
        
        // Victory
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
    
}
