//
//  Custom Data Types.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import Foundation

enum Hero {
    case guardian
    case dragon
    case villagers
}

enum ActionType {
    case attack
    case block
    case protect
}

struct TargetVillain {
    let villainRow: Int?
    let villainNumber: Int
    let villainView: CharacterView?
    
    func getVillainObject(from villainsList: VillainsList) -> Villain {
        let villainsList = villainRow == 0 ? villainsList.hugeVillains : (villainRow == 1 ? villainsList.bigVillains : villainsList.littleVillains)
        let villainObject = villainsList[villainNumber]
        return villainObject
    }
}

struct TargetHero {
    let hero: Hero
    let heroView: CharacterView
}

struct VillainsList {
    let hugeVillains: [Villain]
    let bigVillains: [Villain]
    let littleVillains: [Villain]
    
    func getVillainObject(from targetVillain: TargetVillain) -> Villain {
        let villainsList = targetVillain.villainRow == 0 ? hugeVillains : (targetVillain.villainRow == 1 ? bigVillains : littleVillains)
        let villainObject = villainsList[targetVillain.villainNumber]
        return villainObject
    }
    
    func forEach(do func: ()) {
        
    }
}

struct HerosList {
    let guardian: GuardianClass
    let villagers: VillagersClass
    let dragon: DragonClass
}

struct CharacterStats {
    let name: String
    var hero: Hero?
    var level: Int
    var maxHealth: Int
    var health: Int
    var maxEnergy: Int
    var energy: Int
    var block: Int
    var protection: ProtectionArray
    var protectionIDs: [Int]
    var statusEffects: [String]
    var intent: VillainIntent?
    var deck: [Action]
    var discardPile: [Action?]
}

struct VillainIntent {
    var targetHero: Hero?
    var targetVillain: TargetVillain?
    var action: Action
    var unusedActions: [Action?]
}
