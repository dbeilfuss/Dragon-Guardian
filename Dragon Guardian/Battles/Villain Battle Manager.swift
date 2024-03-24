//
//  Villain Battle Manager.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/23/24.
//

import Foundation

//MARK: - Villain Actions
extension BattleManager: VillainBattleManager {
    func villainActionTaken(self thisVillain: Villain, intent: VillainIntention) {
        let action = intent.action
        let targetVillain = intent.targetVillain
        
        switch action.actionType {
        case .attack:
            let targetHero: HeroClass = herosList.getHero(hero: intent.targetHero!)
            villainAttackPlayed(targetHero: targetHero, action: action, villain: thisVillain)
        case .block:
            villainBlockPlayed(self: thisVillain, action: action)
        case .protect:
            if let protectedVillain = targetVillain {
                villainProtectPlayed(protector: thisVillain, protected: protectedVillain, action: action)
            }
        }
        
        thisVillain.stats.discardPile.append(intent.action)
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
