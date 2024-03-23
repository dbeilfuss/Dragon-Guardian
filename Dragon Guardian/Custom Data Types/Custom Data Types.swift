//
//  Custom Data Types.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import UIKit

enum CharacterType {
    case hero
    case villain
}

enum Hero {
    case guardian
    case dragon
    case villagers
}

struct HerosList {
    let guardian: GuardianClass
    let villagers: VillagersClass
    let dragon: DragonClass
    
    func forEach(do action: (HeroClass) -> Void) {
        // Properties
        let herosList = allHeros()
        
        // Action
        for hero in herosList {
            action(hero)
        }
        
    }
    
    func allHeros() -> [HeroClass] { return [dragon, guardian, villagers] }

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
    var intent: VillainIntention?
    var deck: [Action]
    var discardPile: [Action?]
}

enum ActionType {
    case attack
    case block
    case protect
}

struct VillainsUIStackViews {
    let hugeVillainsStackView: UIStackView
    let bigVillainsStackView: UIStackView
    let littleVillainsStackView: UIStackView
    
    func getVillainUIView(target: TargetVillain) -> UIView {
        var thisStackView: UIStackView
        
        switch target.villainRow {
        case 0: thisStackView = hugeVillainsStackView
        case 1: thisStackView = bigVillainsStackView
        default: thisStackView = littleVillainsStackView
        }
        
        let thisVillain = thisStackView.arrangedSubviews[target.villainNumber]
        
        return thisVillain
    }
    
}

struct TargetVillain {
    let villainRow: Int?
    let villainNumber: Int
    let villainView: CharacterView?
    
    func getVillainObject(from villainsList: VillainsObjects) -> Villain {
        let villainsList = villainRow == 0 ? villainsList.hugeVillains : (villainRow == 1 ? villainsList.bigVillains : villainsList.littleVillains)
        let villainObject = villainsList[villainNumber]
        return villainObject
    }
    
    func getVillainUIView(_ villainsStackViews: VillainsUIStackViews) -> UIView {
        var thisStackView: UIStackView
        
        switch villainRow {
        case 0: thisStackView = villainsStackViews.hugeVillainsStackView
        case 1: thisStackView = villainsStackViews.bigVillainsStackView
        default: thisStackView = villainsStackViews.littleVillainsStackView
        }
        
        let thisVillain = thisStackView.arrangedSubviews[villainNumber]
        
        return thisVillain
    }

}

struct TargetHero {
    let hero: Hero
    let heroView: CharacterView
}

struct VillainIntention {
    var targetHero: Hero?
    var targetVillain: TargetVillain?
    var action: Action
    var unusedActions: [Action?]
}

struct VillainsObjects {
    var hugeVillains: [Villain]
    var bigVillains: [Villain]
    var littleVillains: [Villain]
    
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
    
    mutating func removeVillain(target: TargetVillain) {
        print("removing villain: \(target)")
        var villainRow: [Villain]
        
        // Get Data
        switch target.villainRow {
        case 0:
            villainRow = hugeVillains
        case 1:
            villainRow = bigVillains
        default:
            villainRow = littleVillains
        }
        
        // Remove Villain
        print("removing: \(villainRow[target.villainNumber])")
        villainRow.remove(at: target.villainNumber)

        // Save Data
        switch target.villainRow {
        case 0:
            hugeVillains = villainRow
        case 1:
            bigVillains = villainRow
        default:
            littleVillains = villainRow
        }
        
    }

}
