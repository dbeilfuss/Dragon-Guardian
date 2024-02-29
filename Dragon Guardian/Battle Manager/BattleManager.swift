//
//  GameManager.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation
import UIKit

class BattleManager: battleViewControllerDelegate {
    
    let guardian = Guardian()
    let dragon = Dragon()
    
    var dragonHand: [Action] = []
    var guardianHand: [Action] = []
    
    let littleDragon1 = LittleDragon()
    let littleDragon2 = LittleDragon()
    
    let villains: [Villain] = []
    
    init() {
        self.dragonHand = guardian.fetchNewHand(numberOfActions: 5)
        self.guardianHand = dragon.fetchNewHand(numberOfActions: 5)
    }
    
    func retrieveHeroHands() -> [[Action]] {
        return [guardianHand, dragonHand]
    }
    
    func retrieveVillains() -> [Villain] {
        [littleDragon1, littleDragon2]
    }
    
}
