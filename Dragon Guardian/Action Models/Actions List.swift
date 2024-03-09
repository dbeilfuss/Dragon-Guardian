//
//  Actions List.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

struct genericDefense{
//    let cower = dodge()
}

struct guardianAttacks {
    let punch = basicAttack(level: 1, name: "Punch", cost: 1, description: "Strike with a closed fist.", strength: 1)
    let rock = basicAttack(level: 1, name: "Rock", cost: 2, description: "Hurl nearby object.", strength: 3)
    let dagger = basicAttack(level: 2, name: "Dagger", cost: 3, description: "Use your dagger", strength: 5)
}

struct dragonAttacks {
    let claw = basicAttack(level: 1, name: "Scratch", cost: 1, description: "Slash opponent", strength: 2)
    let bite = basicAttack(level: 1, name: "Bite", cost: 3, description: "Use your teeth", strength: 5)
    let tailWhip = basicAttack(level: 2, name: "Tail Whip", cost: 2, description: "An unexpected blow from behind", strength: 10)
}

struct callsToAction {
    let pray = CallToAction(level: 1, name: "Pray", cost: 3, description: "Call the villagers to pray", strength: 25)
    let volley = CallToAction(level: 2, name: "Volley", cost: 3, description: "Let loose a volley of arrows", strength: 50)
}
