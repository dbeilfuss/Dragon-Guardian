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
        action.attack(from: villain, to: targetHero)
        
        // Defeat
        checkForDefeat()
        
    }
    
    func villainBlockPlayed(self villain: Villain, action: Action) {
        action.block(character: villain)
    }
    
    func villainProtectPlayed(protector: Villain, protected: TargetVillain, action: Action) {
        if let protectedVillain = villainsList.getVillainObject(from: protected) {
            action.protect(protector: protector, protected: protectedVillain)
        }
    }
}
