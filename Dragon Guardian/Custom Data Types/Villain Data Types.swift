//
//  Villain Data Types.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/24/24.
//

import UIKit


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
    
    func getVillainObject(from targetVillain: TargetVillain) -> Villain? {
        let villainsList = targetVillain.villainRow == 0 ? hugeVillains : (targetVillain.villainRow == 1 ? bigVillains : littleVillains)
        var villainObject: Villain?
        if villainsList.count > targetVillain.villainNumber {
            villainObject = villainsList[targetVillain.villainNumber]
        }
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
    
    func getAll() -> [Villain] { return hugeVillains + bigVillains + littleVillains }
    
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
    
    func count() -> Int { return getAll().count }
    
    func removeProtection(protectionID: Int) {
        forEach(smallestFirst: false) {
            $0.stats.protection.removeProtection(protectionID: protectionID)
        }
    }

}
