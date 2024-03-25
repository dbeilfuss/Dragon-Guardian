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
    
    func formIntent(villainsList: VillainsObjects, villainSelf: TargetVillain) {
        
        // Safety First
        if stats.deck.count == 0 {
            stats.deck = stats.discardPile as! [Action]
            stats.discardPile = []
        }
        
        // Form Intent
        let intent = decisionManager.formIntent(deck: stats.deck, discardPile: stats.discardPile, villainSelf: villainSelf, villainsList: villainsList)
        stats.intent = intent
        stats.deck = intent.unusedActions as! [Action]
    }
    
    func drawStartingDeck() -> [Action] {
        let startingDeck = DragonActions().getActions(heroLevel: stats.level)
        return startingDeck
    }
    
}

protocol VillainBattleManager {
    func villainActionTaken(self: Villain, intent: VillainIntention)
}
