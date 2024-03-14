//
//  battleVCDelegate.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import UIKit

extension BattleViewController: battleManagerDelegate {
    
    func updateCharacters(herosList: HerosList, villainsList: VillainsList) {
        
        print("updating characters")
        
        updateHeros(herosList)
        updateVillains(villainsList)
        
    }
    
    func updateHeros(_ herosList: HerosList) {
        print("updating heros")
        
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
        
//        let villagersView =             villagersView.subviews[0] as! VillagerView
//        let villagerStats = herosList.villagers.currentStats()
//        villagersView.update()
        
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
    
}
