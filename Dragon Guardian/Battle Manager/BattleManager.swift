//
//  GameManager.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation
import UIKit

struct VillainsList {
    let hugeVillains: [Villain]
    let bigVillains: [Villain]
    let littleVillains: [Villain]
}

class BattleManager: battleViewControllerDelegate {
    
    let guardian = Guardian()
    let dragon = Dragon()
    
    var dragonHand: [Action] = []
    var guardianHand: [Action] = []
    
    let villainsList: VillainsList = VillainsList(
        hugeVillains: [LittleDragon()],
        bigVillains: [LittleDragon()],
        littleVillains: [LittleDragon(), LittleDragon(), LittleDragon()])
    
    let villains: [Villain] = []
    
    init() {
        self.dragonHand = guardian.fetchNewHand(numberOfActions: 5)
        self.guardianHand = dragon.fetchNewHand(numberOfActions: 5)
    }
    
    func retrieveHeroHands() -> [[Action]] {
        return [dragonHand, guardianHand]
    }
    
    func retrieveVillains() -> VillainsList {
        villainsList
    }
    
}
