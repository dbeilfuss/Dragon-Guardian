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
}

struct TargetHero {
    let hero: Hero
    let heroView: CharacterView
}

struct VillainsList {
    let hugeVillains: [Villain]
    let bigVillains: [Villain]
    let littleVillains: [Villain]
}

struct HerosList {
    let guardian: GuardianClass
    let villagers: VillagersClass
    let dragon: DragonClass
}

struct Protection {
    let strength: Int
    let protector: Character
    let id: Int
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
    var protection: [Protection]
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
