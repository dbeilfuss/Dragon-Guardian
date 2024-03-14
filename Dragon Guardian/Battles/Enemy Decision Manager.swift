//
//  EnemyDecisionManager.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/10/24.
//

import Foundation

class EnemyDecisionManager {
    
    var deck: [Action] = []
    var discardPile: [Action] = []
    var scripted: Bool
    
    var biasedToward: heros?
    var biasedStrength: biasStrength?
    
    enum heros: Int {
        case guardian = 1
        case dragon = 2
        case villagers = 3
    }
    
    enum biasStrength: Int {
        case none = 0
        case minor = 1
        case major = 3
        case always = 8
    }
    
    init(deck: [Action], discardPile: [Action], scripted: Bool, biasedToward: heros? = nil, biasedStrength: biasStrength) {
        self.deck = deck
        self.discardPile = discardPile
        self.scripted = scripted
        self.biasedToward = biasedToward
        self.biasedStrength = biasedStrength
    }
    
    func identifyTarget() -> Int {
        
        var heros = [
            heros.dragon.rawValue,
            heros.guardian.rawValue,
            heros.villagers.rawValue
        ]
        
        for i in 0...(biasedStrength?.rawValue ?? 0) {
            if biasedToward != nil {
                heros.append(biasedToward!.rawValue)
            }
            print(heros)
        }
        
        let target = heros.randomElement()!
        print("targetChosen: \(target)")
        return target
    }
    
    func choseAction() -> Action {
        if scripted {
            let action = deck[0]
            deck.remove(at: 0)
            discardPile.append(action)
            print("action chosen: \(action)")
            return action
        } else {
            let i = Int.random(in: 0...deck.count)
            let action = deck[i]
            deck.remove(at: i)
            discardPile.append(action)
            print("action chosen: \(action)")
            return action
        }
    }
    
}
