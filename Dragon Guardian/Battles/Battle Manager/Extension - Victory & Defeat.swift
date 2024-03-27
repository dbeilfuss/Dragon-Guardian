//
//  Extension - Victory & Defeat.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/26/24.
//

import Foundation

extension BattleManager {
    
    //MARK: - Victory & Defeat
    
    func checkForVictory() {
        
        if villainsList.count() == 0 {
            gameState = .victory
        }
        
        if gameState == .victory {
            narrativeManager.declareVictory()
            delegate?.declareVictory()
        }
        
    }
    
    func checkForDefeat() {
        if herosList.minHealth() <= 0 {
            gameState = .defeat
            print(gameState)
        }
        
        if gameState == .defeat {
            narrativeManager.declareDefeat()
            delegate?.declareDefeat()
        }
    }
    
    func loadNextRound() {
        initializeGameData()
        delegate?.updateForNewRound()
    }
    
}
