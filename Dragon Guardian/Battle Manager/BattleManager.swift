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

struct HerosList {
    let guardian: Guardian
    let villagers: Character? //Needs Updated when Villagers Character is Created
    let dragon: Dragon
}

class BattleManager: battleViewControllerDelegate {
    
    let guardian = Guardian()
    let dragon = Dragon()
    
    var dragonHand: [Action] = []
    var guardianHand: [Action] = []
    
    let villainsList: VillainsList = VillainsList(
        hugeVillains: [BigDragon()],
        bigVillains: [],
        littleVillains: [LittleDragon(), LittleDragon(), LittleDragon(), LittleDragon()])
    
    let villains: [Villain] = []
    
    init() {
        self.dragonHand = guardian.fetchNewHand(numberOfActions: 5)
        self.guardianHand = dragon.fetchNewHand(numberOfActions: 5)
    }
    
    func retrieveHeroHands() -> [[Action]] {
        return [dragonHand, guardianHand]
    }
    
    func retrieveHeros() -> HerosList {
        let herosList: HerosList = HerosList(guardian: guardian, villagers: nil, dragon: dragon)
        return herosList
    }
    
    func retrieveVillains() -> VillainsList {
        villainsList
    }
    
}
