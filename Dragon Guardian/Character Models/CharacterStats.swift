//
//  CharacterStats.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/26/24.
//

import Foundation

struct CharacterStats {
    let name: String
    let level: Int
    let maxHealth: Int
    var health: Int
    let block: Int
    let statusEffects: [String]
    var intent: String?
    let actionsCount: Int?
    var deck: [Action]
}
