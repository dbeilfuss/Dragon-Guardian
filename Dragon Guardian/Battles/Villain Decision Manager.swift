//
//  VillainDecisionManager.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/10/24.
//

import Foundation

class villainDecisionManager {
    
    var deck: [Action] = []
    
    func formIntent(deck: [Action], discardPile: [Action?], villainSelf: TargetVillain, villainsList: VillainsObjects) -> VillainIntention {
        var targetHero: Hero?
        var targetVillain: TargetVillain?
        let action = chooseAction(deck, villainsList: villainsList, discardPile: discardPile)
        
        switch action.actionType {
        case .attack:
            targetHero = identifyTargetHero()
        case .block:
            targetVillain = villainSelf
        case .protect:
            targetVillain = identifyTargetVillain(villainSelf: villainSelf, villainsList: villainsList)
        }
        
        let intent = VillainIntention(targetHero: targetHero, targetVillain: targetVillain, action: action, unusedActions: self.deck)
        
        return intent
    }
    
    func chooseAction(_ deck: [Action], villainsList: VillainsObjects, discardPile: [Action?]) -> Action {
        var filteredDeck = deck
        // Remove Protect Cards if Solo
        let isSolo: Bool = villainsList.count() == 1
        if isSolo {
            filteredDeck = filteredDeck.filter { $0.actionType != .protect }
            if filteredDeck.isEmpty {
                if !discardPile.isEmpty {
                    filteredDeck = discardPile as! [Action]
                    filteredDeck = filteredDeck.filter { $0.actionType != .protect
                    }
                }
            }
        }
        
        // Properties
        let i = Int.random(in: 0...filteredDeck.count-1)
        self.deck = filteredDeck
        let action = self.deck.remove(at: i)
        
        // Response
        print("action chosen: \(action)")
        return action
    }
    
    func identifyTargetVillain(villainSelf: TargetVillain, villainsList: VillainsObjects) -> TargetVillain {
        
        // properties
        var allVillains: [TargetVillain] = []
        let allVillainsLists: [[Villain]] = [villainsList.hugeVillains, villainsList.bigVillains, villainsList.littleVillains]
        
        // conversion and selection
        for x in 0...allVillainsLists.count - 1 {
            if allVillainsLists[x].count > 0 {
                for i in 0...allVillainsLists[x].count - 1 {
                    let targetVillain = TargetVillain(villainRow: x, villainNumber: i, villainView: nil)
                    
                    let isSelf: Bool = { targetVillain.villainRow == villainSelf.villainRow && targetVillain.villainNumber == villainSelf.villainNumber }()
                    
                    if !isSelf {
                        allVillains.append(targetVillain)
                    }
                }
            }
        }
        
        let targetVillain: TargetVillain = allVillains.randomElement()!
        
        print("targetChosen: \(targetVillain)")
        return targetVillain
    }
    
    func identifyTargetHero() -> Hero {
        
        let heros: [Hero] = [.dragon, .guardian, .villagers]
        let target: Hero = heros.randomElement()!
        
        print("targetChosen: \(target)")
        return target
    }
    
}
