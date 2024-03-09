//
//  Custom Data Types.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import Foundation

struct TargetVillain {
    let villainRow: Int?
    let villainNumber: Int
    let villainView: CharacterView?
}

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

struct CharacterStats {
    let name: String
    var level: Int
    var maxHealth: Int
    var health: Int
    var maxEnergy: Int
    var energy: Int
    var block: Int
    var statusEffects: [String]
    var intent: String?
    var deck: [Action]
}
