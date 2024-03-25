//
//  Actions List.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/25/24.
//

import Foundation

//MARK: - Guardian
struct GuardianActions {
    let attacks = GuardianAttacks()
    let blocks = GuardianBlocks()
    let protects = GuardianProtects()
    
    func getActions(heroLevel: Int) -> [Action] {
        let actions = getAllActions()
        let matchingActions: [Action] = actions.filter { $0.level <= heroLevel }
        return matchingActions
    }
    
    func getAllActions() -> [Action] {
        let allActions = attacks.getAllActions() + blocks.getAllActions() + protects.getAllActions()
        return allActions
    }
    
}

struct GuardianAttacks {
    let punch = BasicAttack(level: 1, name: "Punch", cost: 1, description: "Strike with a closed fist.", strength: 6)
    let rock = BasicAttack(level: 2, name: "Rock", cost: 2, description: "Hurl nearby object.", strength: 15)
    let dagger = BasicAttack(level: 3, name: "Dagger", cost: 3, description: "Use your dagger", strength: 25)
    
    func getAllActions() -> [Action] {
        let allActions = [punch, rock, dagger]
        return allActions
    }
}

struct GuardianBlocks {
    let block = BasicBlock(level: 1, name: "Block", cost: 1, description: "Block the incoming blow", strength: 5)
    let dodge = BasicBlock(level: 2, name: "Dodge", cost: 2, description: "Move to the side.", strength: 12)
    let roll = BasicBlock(level: 3, name: "Roll", cost: 3, description: "Roll out of the way.", strength: 20)
    
    func getAllActions() -> [Action] {
        let allActions = [block, dodge, roll]
        return allActions
    }
}

struct GuardianProtects {
    let brave = BasicProtect(level: 1, name: "Brave", cost: 1, description: "Bravely attempt to stop the incoming attack.", strength: 6)
    let defiance = BasicProtect(level: 2, name: "Defiance", cost: 2, description: "Stand between the enemy, and your ally.", strength: 15)
    let aegis = BasicProtect(level: 3, name: "Aegis", cost: 3, description: "Willingly risk it all to protect your friend", strength: 25)
    
    func getAllActions() -> [Action] {
        let allActions = [brave, defiance, aegis]
        return allActions
    }
}

//MARK: - Dragon

struct DragonActions {
    let attacks = DragonAttacks()
    let blocks = DragonBlocks()
    let protects = DragonProtects()
    
    func getActions(heroLevel: Int) -> [Action] {
        let actions = getAllActions()
        let matchingActions: [Action] = actions.filter { $0.level <= heroLevel }
        return matchingActions
    }
    
    func getAllActions() -> [Action] {
        let allActions = attacks.getAllActions() + blocks.getAllActions() + protects.getAllActions()
        return allActions
    }
    
}

struct DragonAttacks {
    let claw = BasicAttack(level: 1, name: "Claw", cost: 1, description: "Slash opponent", strength: 6)
    let tailWhip = BasicAttack(level: 2, name: "Tail Whip", cost: 2, description: "An unexpected blow from behind", strength: 15)
    let bite = BasicAttack(level: 3, name: "Bite", cost: 4, description: "Use your teeth", strength: 25)
    
    func getAllActions() -> [Action] {
        let allActions = [claw, tailWhip, bite]
        return allActions
    }
}

struct DragonBlocks {
    let growl = BasicBlock(level: 1, name: "Growl", cost: 1, description: "Make your enemies' knees shake", strength: 5)
    let anticipate = BasicBlock(level: 2, name: "Anticipate", cost: 2, description: "Stop the incoming blow.", strength: 12)
    let cocoon = BasicBlock(level: 3, name: "Cocoon", cost: 4, description: "Your Wings encircle you in a protective shell", strength: 20)
    
    func getAllActions() -> [Action] {
        let allActions = [growl, anticipate, cocoon]
        return allActions
    }
}

struct DragonProtects {
    let pact = BasicProtect(level: 1, name: "Pact", cost: 1, description: "Honorably attempt to stop the incoming attack.", strength: 6)
    let shield = BasicProtect(level: 2, name: "Shield", cost: 2, description: "Provide cover for your ally.", strength: 15)
    let sacrifice = BasicProtect(level: 3, name: "Sacrifice", cost: 3, description: "Willingly risk it all to protect your friend", strength: 25)
    
    func getAllActions() -> [Action] {
        let allActions = [pact, shield, sacrifice]
        return allActions
    }
}

