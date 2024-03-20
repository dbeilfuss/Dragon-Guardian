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

struct HerosClass {
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
    var intent: VillainIntentions?
    var deck: [Action]
    var discardPile: [Action?]
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

struct VillainIntentions {
    var targetHero: Hero?
    var targetVillain: TargetVillain?
    var action: Action
    var unusedActions: [Action?]
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
    
    func forEach(smallestFirst: Bool, do action: (Villain) -> Void) {
        // Properties
        var allVillainLists = getAllLists()
        if !smallestFirst {
            allVillainLists = allVillainLists.reversed()
        }
        
        // Action
        for villainList in allVillainLists {
            villainList.forEach(action)
        }
        
    }
    
    func formIntentions() {
        let allVillainLists: [[Villain]] = getAllLists().reversed()
        for x in 0...allVillainLists.count - 1 {
            if allVillainLists[x].count > 0 {
                for i in 0...allVillainLists[x].count - 1 {
                    let villainSelf = TargetVillain(villainRow: x, villainNumber: i, villainView: nil)
                    allVillainLists[x][i].formIntent(villainsList: self, villainSelf: villainSelf)
                }
            }
        }
    }
    
    func getAllLists() -> [[Villain]] { return [littleVillains, bigVillains, hugeVillains] }
    
    func map<T>(_ transform: (Villain) -> T) -> [T] {
        let allVillains = hugeVillains + bigVillains + littleVillains
        return allVillains.map(transform)
    }


}
