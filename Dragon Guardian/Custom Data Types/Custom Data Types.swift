//
//  Custom Data Types.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import UIKit


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

    func getHero(hero: Hero) -> HeroClass {
        let thisHero = hero == .dragon ? dragon : (hero == .guardian ? guardian : villagers)
        return thisHero
    }
    
}

struct TargetHero {
    let hero: Hero
    let heroView: CharacterView
}


enum ActionType {
    case attack
    case block
    case protect
}

