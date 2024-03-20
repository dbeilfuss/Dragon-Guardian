//
//  battleVCDelegate.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import UIKit

extension BattleViewController: battleManagerDelegate {

    //MARK: - Update Characters
    
    func updateCharacters(herosList: HerosClass, villainsList: VillainsList) {
        updateHeros(herosList)
        updateVillains(villainsList)
        updateHands()
    }
    
    func updateHeros(_ herosList: HerosClass) {
        
        let herosArray: [CharacterView] = [
            hero1View.subviews[0] as! CharacterView,
            hero2View.subviews[0] as! CharacterView,
        ]
        
        let herosStatsArray: [CharacterStats] = [
            herosList.guardian.currentStats(),
            herosList.dragon.currentStats(),
        ]
        
        for i in 0...herosArray.count - 1 {
            herosArray[i].updateCharacter(herosStatsArray[i])
        }
        
    }
    
    func updateVillains(_ villainsList: VillainsList) {
        
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
    
    //MARK: - Next Turn
    
    func nextTurn(actionsCarriedOut: [VillainIntentions], updatedHerosList: HerosClass, updatedVillainsList: VillainsList) {
        print("actionsCarriedOut: \(actionsCarriedOut)")
    }
    
}
