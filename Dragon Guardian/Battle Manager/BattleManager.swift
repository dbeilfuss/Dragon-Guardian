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
        hugeVillains: [],
        bigVillains: [BigDragon()],
        littleVillains: [LittleDragon(), BigDragon()])
    
    let villains: [Villain] = []
    
    init() {
        self.guardianHand = guardian.fetchNewHand(numberOfActions: 5)
        self.dragonHand = dragon.fetchNewHand(numberOfActions: 5)
    }
    
    func retrieveHeroHands() -> [[Action]] {
        return [guardianHand, dragonHand]
    }
    
    func retrieveHeros() -> HerosList {
        let herosList: HerosList = HerosList(guardian: guardian, villagers: villagers, dragon: dragon)
        return herosList
    }
    
    func retrieveVillains() -> VillainsList {
        villainsList
    }
    
    func actionPlayed(hero: Int, action: Int, villainList villainType: Int?, target: Int) {
        print("action played")
        
        // Properties
        let activeHero = hero == 1 ? guardian : dragon
        let heroHand = hero == 1 ? guardianHand : dragonHand
        let playedAction = heroHand[action]
        var villainsList = villainType == 0 ? self.villainsList.hugeVillains : (villainType == 1 ? self.villainsList.bigVillains : self.villainsList.littleVillains)
        var villain = villainsList[target]

        // Feedback
        print("hero: \(activeHero.name)")
        print("playedAction: \(playedAction.name)")
        print("villain: \(villain.name)")
        
        print(playedAction)
        
    }
}
