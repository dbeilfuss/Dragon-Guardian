//
//  Villain.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

class Villain: Character {
        
    var decisionManager: villainDecisionManager = villainDecisionManager()
    
    func takeAction(battleManager: VillainBattleManager) {
        if let intent = stats.intent {
            battleManager.villainActionTaken(self: self, intent: intent)
        }
    }
    
    func formIntent(villainsList: VillainsList, villainSelf: TargetVillain) {
        let intent = decisionManager.formIntent(deck: stats.deck, villainSelf: villainSelf, villainsList: villainsList)
        stats.intent = intent
            stats.deck = intent.unusedActions as! [Action]
    }
    
}

protocol VillainBattleManager {
    func villainActionTaken(self: Villain, intent: VillainIntention)
}
