//
//  Game NarrativeManager Data Types.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/23/24.
//

import Foundation

enum GameState {
    case initializing
    case inProgress
    case victory
    case defeat
}

struct RoundSetup {
    let environment: String
    let villains: VillainsObjects
    let heros: HerosList
}

struct DeckSetup {   // Count of how many of each action the hand receives at each heroLevel
    let attacksLev1: Int
    let blocksLev1: Int
    let protectsLev1: Int

    let attacksLev2: Int
    let blocksLev2: Int
    let protectsLev2: Int

    let attacksLev3: Int
    let blocksLev3: Int
    let protectsLev3: Int
    
    func createDeck(heroLevel: Int, actions: [Action]) -> [Action] {
        var deck: [Action] = []
        
        let attacks: [Action] = actions.filter { $0.actionType == .attack }
        let blocks: [Action] = actions.filter { $0.actionType == .block }
        let protects: [Action] = actions.filter { $0.actionType == .protect }

        if heroLevel == 1 {
            for _ in 1...attacksLev1 {
                deck.append(attacks.filter {$0.level == heroLevel}.randomElement()!)
            }
            for _ in 1...blocksLev1 {
                deck.append(blocks.filter {$0.level == heroLevel}.randomElement()!)
            }
            for _ in 1...protectsLev1 {
                deck.append(protects.filter {$0.level == heroLevel}.randomElement()!)
            }
        }
        
        if heroLevel == 2 {
            for _ in 1...attacksLev2 {
                deck.append(attacks.filter {$0.level == heroLevel}.randomElement()!)
            }
            for _ in 1...blocksLev2 {
                deck.append(blocks.filter {$0.level == heroLevel}.randomElement()!)
            }
            for _ in 1...protectsLev2 {
                deck.append(protects.filter {$0.level == heroLevel}.randomElement()!)
            }
        }
        
        if heroLevel == 3 {
            for _ in 1...attacksLev3 {
                deck.append(attacks.filter {$0.level == heroLevel}.randomElement()!)
            }
            for _ in 1...blocksLev3 {
                deck.append(blocks.filter {$0.level == heroLevel}.randomElement()!)
            }
            for _ in 1...protectsLev3 {
                deck.append(protects.filter {$0.level == heroLevel}.randomElement()!)
            }
        }
        
        return deck
    }
}

struct VillainRound {
    let hugeVillains: Int
    let bigVillains: Int
    let littlVillains: Int
}
