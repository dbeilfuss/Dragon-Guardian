//
//  Actions List.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

//MARK: - Guardian
struct guardianAttacks {
    let punch = BasicAttack(level: 1, name: "Punch", cost: 1, description: "Strike with a closed fist.", strength: 2)
    let rock = BasicAttack(level: 2, name: "Rock", cost: 2, description: "Hurl nearby object.", strength: 4)
    let dagger = BasicAttack(level: 3, name: "Dagger", cost: 3, description: "Use your dagger", strength: 8)
}

struct guardianBlocks {
    let block = BasicBlock(level: 1, name: "Block", cost: 1, description: "Block the incoming blow", strength: 2)
    let dodge = BasicBlock(level: 2, name: "Dodge", cost: 2, description: "Move to the side.", strength: 4)
    let roll = BasicBlock(level: 3, name: "Roll", cost: 3, description: "Roll out of the way.", strength: 8)
}

struct guardianProtects {
    let brave = BasicProtect(level: 1, name: "Brave", cost: 1, description: "Bravely attempt to stop the incoming attack.", strength: 2)
    let defiance = BasicProtect(level: 2, name: "Defiance", cost: 2, description: "Stand between the enemy, and your ally.", strength: 4)
    let aegis = BasicProtect(level: 3, name: "Aegis", cost: 3, description: "Willingly risk it all to protect your friend", strength: 8)
}

//MARK: - Dragon
struct dragonAttacks {
    let claw = BasicAttack(level: 1, name: "Claw", cost: 1, description: "Slash opponent", strength: 2)
    let tailWhip = BasicAttack(level: 2, name: "Tail Whip", cost: 2, description: "An unexpected blow from behind", strength: 4)
    let bite = BasicAttack(level: 3, name: "Bite", cost: 4, description: "Use your teeth", strength: 10)
}

struct dragonBlocks {
    let growl = BasicBlock(level: 1, name: "Growl", cost: 1, description: "Make your enemies' knees shake", strength: 1)
    let anticipate = BasicBlock(level: 2, name: "Anticipate", cost: 2, description: "Stop the incoming blow.", strength: 2)
    let cocoon = BasicBlock(level: 3, name: "Cocoon", cost: 4, description: "Your Wings encircle you in a protective shell", strength: 10)
}

struct dragonProtects {
    let pact = BasicProtect(level: 1, name: "Pact", cost: 1, description: "Honorably attempt to stop the incoming attack.", strength: 2)
    let shield = BasicProtect(level: 2, name: "Shield", cost: 2, description: "Provide cover for your ally.", strength: 4)
    let sacrifice = BasicProtect(level: 3, name: "Sacrifice", cost: 3, description: "Willingly risk it all to protect your friend", strength: 8)
}

