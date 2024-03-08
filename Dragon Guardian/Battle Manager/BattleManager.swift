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
    let villagers: Villagers
    let dragon: Dragon
}

class BattleManager: battleViewControllerDelegate {
    
    let guardian = Guardian()
    let dragon = Dragon()
    let villagers = Villagers()
    
    var dragonHand: [Action] = []
    var guardianHand: [Action] = []
    var villagersHand: [Action] = []
    
    let villainsList: VillainsList = VillainsList(
        hugeVillains: [BigDragon(), BigDragon()],
        bigVillains: [BigDragon()],
        littleVillains: [LittleDragon(), LittleDragon(), LittleDragon()])
    
    let villains: [Villain] = []
    
    init() {
        self.dragonHand = guardian.fetchNewHand(numberOfActions: 5)
        self.guardianHand = dragon.fetchNewHand(numberOfActions: 5)
    }
    
    func retrieveHeroHands() -> [[Action]] {
        return [dragonHand, guardianHand]
    }
    
    func retrieveHeros() -> HerosList {
        let herosList: HerosList = HerosList(guardian: guardian, villagers: villagers, dragon: dragon)
        return herosList
    }
    
    func retrieveVillains() -> VillainsList {
        villainsList
    }
    
}
