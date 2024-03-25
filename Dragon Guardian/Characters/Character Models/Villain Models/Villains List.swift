//
//  Villains List.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/24/24.
//

import Foundation

struct VillainsList {
    
    func getVillains(for villainRound: VillainRound) -> VillainsObjects {
        var villains: VillainsObjects = VillainsObjects(hugeVillains: [], bigVillains: [], littleVillains: [])
        
        if villainRound.hugeVillains > 0 {
            for _ in 1...villainRound.hugeVillains {
                villains.hugeVillains.append(randomVillain(level: 3))
            }
        }
        
        if villainRound.bigVillains > 0 {
            for _ in 1...villainRound.bigVillains {
                villains.bigVillains.append(randomVillain(level: 2))
            }
        }
        
        if villainRound.littlVillains > 0 {
            for _ in 1...villainRound.littlVillains {
                villains.littleVillains.append(randomVillain(level: 1))
            }
        }
        
        print("chosenVillains: \(villains)")
        
        return villains
    }
    
    func randomVillain(level: Int) -> Villain {
        let filteredVillains = getAllVillains()
            .filter { $0.stats.level == level }
        
        let villain = filteredVillains.randomElement()!
        return villain
    }
    
    func getAllVillains() -> [Villain] {
        let allVillains = AllVillains()
        let allVillainsList = allVillains.hugeVillains + allVillains.bigVillains + allVillains.littVillains
        
        return allVillainsList
    }
}

struct AllVillains {
    let hugeVillains = [
        HugeDragon()
    ]
    let bigVillains = [
        BigDragon()
    ]
    let littVillains = [
        LittleDragon()
    ]
}
