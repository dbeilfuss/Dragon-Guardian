//
//  GameManager.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation
import UIKit



class BattleManager: battleViewControllerDelegate {
    
    //MARK: - Properties
    
    let guardian = Guardian()
    let dragon = Dragon()
    let villagers = Villagers()
    
    var dragonHand: [Action] = []
    var guardianHand: [Action] = []
    var villagersHand: [Action] = []
    
    let villainsList: VillainsList = VillainsList(
        hugeVillains: [],
        bigVillains: [],
        littleVillains: [LittleDragon(), BigDragon(), LittleDragon()])
    
    var delegate: battleManagerDelegate?
    
    //MARK: - Init
    
    init() {
        self.guardianHand = guardian.fetchNewHand(numberOfActions: 5)
        self.dragonHand = dragon.fetchNewHand(numberOfActions: 5)
    }
    
    func setDelegate(_ delegate: battleManagerDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - Retrieve Data
    
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

    //MARK: - Actions
    
    func actionPlayed(hero activeHero: Int, action actionPlayed: Int, villainAttacked: TargetVillain) {
        print("action played")
        
        // Properties
        let hero = activeHero == 1 ? guardian : dragon
        let heroHand = activeHero == 1 ? guardianHand : dragonHand
        let action = heroHand[actionPlayed]
        let villainsList = villainAttacked.villainRow == 0 ? self.villainsList.hugeVillains : (villainAttacked.villainRow == 1 ? self.villainsList.bigVillains : self.villainsList.littleVillains)
        let villain = villainsList[villainAttacked.villainNumber]

        // Feedback
        print("hero: \(hero.stats.name)")
        print("action: \(action.name)")
        print("target: \(villain.stats.name)")
        
        // Cost
        if hero.stats.energy >= action.cost {
            // Attack
            action.attack(from: hero, to: villain)
            
            // updateUI
            let herosList = HerosList(guardian: guardian, villagers: villagers, dragon: dragon)
            
            delegate?.updateCharacters(herosList: herosList, villainsList: self.villainsList)
        } else {
            print("not enough energy \(hero.stats.energy)")
        }

        
    }
    
}

//MARK: - Protocol: View Controller
protocol battleManagerDelegate {
    func updateCharacters(herosList: HerosList, villainsList: VillainsList)
}
