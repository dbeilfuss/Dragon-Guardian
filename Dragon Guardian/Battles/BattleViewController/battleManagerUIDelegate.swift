//
//  battleManagerUIDelegate.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import UIKit

extension BattleViewController: battleManagerUIDelegate {

    //MARK: - Update Characters
    
    func updateCharacters(herosList: HerosList, villainsList: VillainsObjects) {
        updateHeros(herosList)
        updateVillains(villainsList)
        updateHands()
    }
    
    func updateHeros(_ herosList: HerosList) {
        
        let herosArray: [CharacterViewUpdateDelegate] = [
            hero1View.subviews[0] as! CharacterViewUpdateDelegate,
            hero2View.subviews[0] as! CharacterViewUpdateDelegate,
            villagersView.subviews[0] as! CharacterViewUpdateDelegate
        ]
        
        let herosStatsArray: [CharacterStats] = [
            herosList.guardian.currentStats(),
            herosList.dragon.currentStats(),
            herosList.villagers.currentStats()
        ]
        
        for i in 0...herosArray.count - 1 {
            herosArray[i].updateCharacter(herosStatsArray[i])
        }
        
    }
    
    func updateVillains(_ villainsList: VillainsObjects) {
        
        let villainsStackViews: [UIStackView] = [
            hugeVillainsStackView,
            bigVillainsStackView,
            littleVillainsStackView
        ]
        
        let villainsLists: [[Character]] = [
            villainsList.hugeVillains,
            villainsList.bigVillains,
            villainsList.littleVillains
        ]
        
        for stackInt in 0...villainsStackViews.count - 1 {
            let subviews = villainsStackViews[stackInt].subviews
            let thisVillainList = villainsLists[stackInt]
            
            if subviews.count > 0 {
                for subInt in 0...subviews.count - 1 {
                    let villainView = subviews[subInt] as! CharacterView
                    let villainStats = thisVillainList[subInt].currentStats()
                    villainView.updateCharacter(villainStats)
                }
            }
        }
    }
    
    func updateHands() {
        hero1HandTableView.reloadData()
        hero2HandTableView.reloadData()
    }
    
    func removeVillain(_ villain: TargetVillain) {
        
        let villansList = VillainsUIStackViews(hugeVillainsStackView: hugeVillainsStackView, bigVillainsStackView: bigVillainsStackView, littleVillainsStackView: littleVillainsStackView)
        
        let thisVillain = villansList.getVillainUIView(target: villain)
        let superView = thisVillain.superview as! UIStackView
        thisVillain.removeFromSuperview()
        
        // Retag
        for i in superView.arrangedSubviews.indices {
            let subview = superView.arrangedSubviews[i] as! CharacterView
            subview.tag = i
            subview.enemyNumber = i
        }
        
        
    }
    
    //MARK: - Next Turn
    
    func nextTurn(actionsCarriedOut: [VillainIntention], updatedHerosList: HerosList, updatedVillainsList: VillainsObjects) {
        print("actionsCarriedOut: \(actionsCarriedOut)")
    }
    
    //MARK: - Victory & Defeat
    
    func declareVictory() {
        gameState = .victory
        transitionScreen()
    }
    
    func declareDefeat() {
        gameState = .defeat
        transitionScreen()
    }
    
    func updateForNewRound() {
        resetHands()
        resetHeros()
        resetVillains()
        initializeBattle()
    }
    
}
