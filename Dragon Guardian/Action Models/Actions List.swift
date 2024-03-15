//
//  Actions List.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

struct guardianAttacks {
    let punch = BasicAttack(level: 1, name: "Punch", cost: 1, description: "Strike with a closed fist.", strength: 2)
    let rock = BasicAttack(level: 2, name: "Rock", cost: 2, description: "Hurl nearby object.", strength: 4)
    let dagger = BasicAttack(level: 3, name: "Dagger", cost: 3, description: "Use your dagger", strength: 8)
}

struct guardianBlock {
    let block = BasicBlock(level: 1, name: "Block", cost: 1, description: "Block the incoming blow", strength: 2)
    let dodge = BasicBlock(level: 2, name: "Dodge", cost: 2, description: "Move to the side.", strength: 4)
    let roll = BasicBlock(level: 3, name: "Roll", cost: 3, description: "Roll out of the way.", strength: 8)
}

struct dragonAttacks {
    let claw = BasicAttack(level: 1, name: "Claw", cost: 1, description: "Slash opponent", strength: 2)
    let tailWhip = BasicAttack(level: 2, name: "Tail Whip", cost: 2, description: "An unexpected blow from behind", strength: 4)
    let bite = BasicAttack(level: 3, name: "Bite", cost: 4, description: "Use your teeth", strength: 10)
}

struct dragonBlock {
    let growl = BasicBlock(level: 1, name: "Growl", cost: 1, description: "Make your enemies' knees shake", strength: 1)
    let anticipate = BasicBlock(level: 2, name: "Anticipate", cost: 2, description: "Stop the incoming blow.", strength: 2)
    let cocoon = BasicBlock(level: 3, name: "Cocoon", cost: 4, description: "Your Wings encircle you in a protective shell", strength: 10)
}

//struct callsToAction {
//    let pray = CallToAction(level: 1, name: "Pray", cost: 3, description: "Call the villagers to pray", strength: 25)
//    let volley = CallToAction(level: 2, name: "Volley", cost: 3, description: "Let loose a volley of arrows", strength: 50)
//}

