//
//  actionCellSelectorDelegate.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import UIKit

extension BattleViewController: actionCellSelectorDelegate {
    
    
    //MARK: - UILongPressGestureRecognizer
    
    func actionSelected(actionType: ActionType, hero: Hero, fingerPosition: CGPoint) {
        
        let heroNum = getHeroNum(hero: hero)
        
        print("actionSelected: hero: \(hero)")
        print("fingerPosition: \(fingerPosition)")
        
        toggleTargetVisibility(hero: heroNum)
        moveTargetSymbol(actionType: actionType, heroType: hero, heroNum: heroNum, fingerPosition: fingerPosition)
    }
    
    func didDragToPoint(actionType: ActionType, hero: Hero, fingerPosition: CGPoint) {
        let heroNum = getHeroNum(hero: hero)
        moveTargetSymbol(actionType: actionType, heroType: hero, heroNum: heroNum, fingerPosition: fingerPosition)
    }
    
    func didEndDragging(hero: Hero, fingerPosition: CGPoint, cellNumber: Int, actionType: ActionType) {
        
        let heroNum = getHeroNum(hero: hero)
        let relativeTable = identifyRelativeTable(hero: heroNum)
        
        switch actionType {
        case .attack:
            let targetVillain: TargetVillain = identifyTargetVillain(fingerPosition: fingerPosition, relativeTable: relativeTable, hero: hero)
            
            // UI
            toggleTargetVisibility(hero: heroNum)
            targetVillain.villainView?.targetLock(false, hero: hero)
            
            // BattleManager
            if targetVillain.villainRow != nil {
                battleManager.actionPlayed(actionType: .attack, hero: hero, action: cellNumber, targetVillain: targetVillain, targetHero: nil)
            }
            
        case .block:
            let targetHero: TargetHero? = identifyThisHero(hero: hero, fingerPosition: fingerPosition, relativeTable: relativeTable)
            
            // UI
            toggleTargetVisibility(hero: heroNum)
            targetHero?.heroView?.targetLock(false, hero: hero)
            
            // BattleManager
            if targetHero != nil {
                battleManager.actionPlayed(actionType: .block, hero: hero, action: cellNumber, targetVillain: nil, targetHero: targetHero?.hero)
            }
            
        case .protect:
            
            let protectedHero: TargetHero? = identifyOtherHeros(protector: hero, fingerPosition: fingerPosition, relativeTable: relativeTable)
            
            // UI
            toggleTargetVisibility(hero: heroNum)
            protectedHero?.heroView?.targetLock(false, hero: hero)
            protectedHero?.villagerView?.targetLock(false, hero: hero)
            
            // BattleManager
            if protectedHero != nil {
                battleManager.actionPlayed(actionType: .protect, hero: hero, action: cellNumber, targetVillain: nil, targetHero: protectedHero?.hero)
            }
        }
        
    }
    
    //MARK: - UI
    
    func toggleTargetVisibility(hero target: Int) {
        let targetViews: [UIImageView] = [targetImage1, targetImage2]
        let thisTarget = targetViews[target-1]
        
        if thisTarget.image == nil {
            thisTarget.image = UIImage(named: "Target")
        }
        
        thisTarget.isHidden = !thisTarget.isHidden
    }
    
    //MARK: - Utility
    
    func moveTargetSymbol(actionType: ActionType, heroType: Hero, heroNum: Int, fingerPosition: CGPoint) {
        // identify correct target symbol - the target that moves with finger position
        let targetViews: [UIImageView] = [targetImage1, targetImage2]
        let thisTarget = targetViews[heroNum-1]
        
        let relativeTable: UITableView = identifyRelativeTable(hero: heroNum)
        let convertedPoint = relativeTable.convert(fingerPosition, to: view)
        
        // move target symbol
        thisTarget.center = convertedPoint
        
        switch actionType {
        case .attack:
            let _ = identifyTargetVillain(fingerPosition: fingerPosition, relativeTable: relativeTable, hero: heroType)
        case .block:
            let _ = identifyThisHero(hero: heroType, fingerPosition: fingerPosition, relativeTable: relativeTable)
        case .protect:
            let _ = identifyOtherHeros(protector: heroType, fingerPosition: fingerPosition, relativeTable: relativeTable)
        }
        
    }
    
    func identifyRelativeTable(hero: Int) -> UITableView {
        // identify correct table - to base finger position off of
        let tableViews: [UITableView] = [hero1HandTableView, hero2HandTableView]
        return tableViews[hero-1]
        
    }
    
    //MARK: - Identify Target
    
    func identifyTargetVillain(fingerPosition: CGPoint, relativeTable: UITableView, hero: Hero) -> TargetVillain {
        var isTargetLocked: Bool = false
        let enemyStackViews: [UIStackView] = [littleVillainsStackView, bigVillainsStackView, hugeVillainsStackView]
        
        var villainRow: Int?
        var characterNumber: Int = 0
        var character: CharacterView = CharacterView()
        
        for stack in enemyStackViews {
            for villain in
                    stack.arrangedSubviews {
                if let targetableVillain = villain as? CharacterView {
                    if !isTargetLocked && targetableVillain.bounds.contains(relativeTable.convert(fingerPosition, to: villain)) {
                        targetableVillain.targetLock(true, hero: hero)
                        isTargetLocked = true
                        villainRow = stack.tag
                        characterNumber = targetableVillain.enemyNumber
                        character = targetableVillain
                    } else {
                        targetableVillain.targetLock(false, hero: hero)
                    }
                }
            }
        }
        
        let targetCharacter: TargetVillain = TargetVillain(villainRow: villainRow, villainNumber: characterNumber, villainView: character)
        return targetCharacter
        
    }
    
    func identifyThisHero(hero: Hero, fingerPosition: CGPoint, relativeTable: UITableView) -> TargetHero? {
        var isTargetLocked: Bool = false
        let heroView: CharacterView? = hero == .guardian ? hero1View.subviews.first as? CharacterView : hero2View.subviews.first as? CharacterView
        
        if heroView != nil {
            if !isTargetLocked && heroView!.bounds.contains(relativeTable.convert(fingerPosition, to: heroView)) {
                heroView!.targetLock(true, hero: hero)
                isTargetLocked = true
                return TargetHero(hero: hero, heroView: heroView!, villagerView: nil)
            }
            heroView!.targetLock(false, hero: hero)
        }
        return nil
    }
    
    func identifyOtherHeros(protector: Hero, fingerPosition: CGPoint, relativeTable: UITableView) -> TargetHero? {

        var isTargetLocked: Bool = false
        
        let protectedHeroView1: CharacterView? = protector == .dragon ? hero1View.subviews.first as? CharacterView : hero2View.subviews.first as? CharacterView
        let protectedHero1: Hero = protector == .dragon ? .guardian : .dragon
        let villagerView: VillagersView = villagersView.subviews.first as! VillagersView
        if !isTargetLocked && protectedHeroView1!.bounds.contains(relativeTable.convert(fingerPosition, to: protectedHeroView1)) {
            protectedHeroView1!.targetLock(true, hero: protector)
            isTargetLocked = true
            print("protecting")
            
            return TargetHero(hero: protectedHero1, heroView: protectedHeroView1!, villagerView: nil)
        }
        protectedHeroView1!.targetLock(false, hero: protector)
        
        if !isTargetLocked && villagerView.bounds.contains(relativeTable.convert(fingerPosition, to: villagerView)) {
            villagerView.targetLock(true, hero: protector)
            isTargetLocked = true
            print("protecting")
            
            return TargetHero(hero: .villagers, heroView: nil, villagerView: villagerView)
        }
        villagerView.targetLock(false, hero: protector)
        return nil
    }
}
