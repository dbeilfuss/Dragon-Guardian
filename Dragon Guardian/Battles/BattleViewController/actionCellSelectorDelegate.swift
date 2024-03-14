//
//  actionCellSelectorDelegate.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import UIKit

extension BattleViewController: actionCellSelectorDelegate {
    
    
    //MARK: - UILongPressGestureRecognizer
    
    func actionSelected(actionType: ActionType, hero: Heros, fingerPosition: CGPoint) {
        
        let heroNum = getHeroNum(hero: hero)
        
        print("actionSelected: hero: \(hero)")
        print("fingerPosition: \(fingerPosition)")
        
        toggleTargetVisibility(hero: heroNum)
        moveTargetSymbol(actionType: actionType, heroType: hero, heroNum: heroNum, fingerPosition: fingerPosition)
    }
    
    func didDragToPoint(actionType: ActionType, hero: Heros, fingerPosition: CGPoint) {
        let heroNum = getHeroNum(hero: hero)
        moveTargetSymbol(actionType: actionType, heroType: hero, heroNum: heroNum, fingerPosition: fingerPosition)
    }
    
    func didEndDragging(hero: Heros, fingerPosition: CGPoint, cellNumber: Int, actionType: ActionType) {
        
        let heroNum = getHeroNum(hero: hero)
        let relativeTable = identifyRelativeTable(hero: heroNum)
        
        switch actionType {
        case .attack:
            let targetVillain: TargetVillain = identifyTargetVillain(fingerPosition: fingerPosition, relativeTable: relativeTable)
            
            // UI
            toggleTargetVisibility(hero: heroNum)
            targetVillain.villainView?.targetLock(false, hero: heroNum)
            
            if targetVillain.villainRow != nil {
                // BattleManager
                battleDelegate.actionPlayed(actionType: .attack, hero: hero, action: cellNumber, targetVillain: targetVillain, targetHero: nil)
            }
            
        case .defend:
            let targetHero: TargetHero? = identifyTargetHero(hero: hero, fingerPosition: fingerPosition, relativeTable: relativeTable)
            
            // UI
            toggleTargetVisibility(hero: heroNum)
            targetHero?.heroView.targetLock(false, hero: heroNum)
            
            if targetHero != nil {
                battleDelegate.actionPlayed(actionType: .defend, hero: hero, action: cellNumber, targetVillain: nil, targetHero: targetHero?.hero)
            }
            
        case .protect:
            return
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
    
    func moveTargetSymbol(actionType: ActionType, heroType: Heros, heroNum: Int, fingerPosition: CGPoint) {
        // identify correct target symbol - the target that moves with finger position
        let targetViews: [UIImageView] = [targetImage1, targetImage2]
        let thisTarget = targetViews[heroNum-1]
        
        let relativeTable: UITableView = identifyRelativeTable(hero: heroNum)
        let convertedPoint = relativeTable.convert(fingerPosition, to: view)
        
        // move target symbol
        thisTarget.center = convertedPoint
        
        switch actionType {
        case .attack:
            let _ = identifyTargetVillain(fingerPosition: fingerPosition, relativeTable: relativeTable)
        case .defend:
            let _ = identifyTargetHero(hero: heroType, fingerPosition: fingerPosition, relativeTable: relativeTable)
        case .protect:
            return
        }
        
    }
    
    func identifyRelativeTable(hero: Int) -> UITableView {
        // identify correct table - to base finger position off of
        let tableViews: [UITableView] = [hero1HandTableView, hero2HandTableView]
        return tableViews[hero-1]
        
    }
    
    //MARK: - Identify Target
    
    func identifyTargetVillain(fingerPosition: CGPoint, relativeTable: UITableView) -> TargetVillain {
        var isTargetLocked: Bool = false
        let enemyStackViews: [UIStackView] = [littleVillainsStackView, bigVillainsStackView, hugeVillainsStackView]
        
        var villainRow: Int?
        var characterNumber: Int = 0
        var character: CharacterView = CharacterView()
        
        for stack in enemyStackViews {
            for enemy in
                    stack.arrangedSubviews {
                if let enemyCharacter = enemy as? CharacterView {
                    if !isTargetLocked && enemyCharacter.bounds.contains(relativeTable.convert(fingerPosition, to: enemy)) {
                        enemyCharacter.targetLock(true, hero: relativeTable.tag)
                        isTargetLocked = true
                        villainRow = stack.tag
                        characterNumber = enemyCharacter.enemyNumber
                        character = enemyCharacter
                    } else {
                        enemyCharacter.targetLock(false, hero: relativeTable.tag)
                    }
                }
            }
        }
        
        let targetCharacter: TargetVillain = TargetVillain(villainRow: villainRow, villainNumber: characterNumber, villainView: character)
        return targetCharacter
        
    }
    
    func identifyTargetHero(hero: Heros, fingerPosition: CGPoint, relativeTable: UITableView) -> TargetHero? {
        var isTargetLocked: Bool = false
        let heroNum = getHeroNum(hero: hero)
        let heroView: CharacterView? = hero == .guardian ? hero1View.subviews.first as? CharacterView : hero2View.subviews.first as? CharacterView
        
        if heroView != nil {
            if !isTargetLocked && heroView!.bounds.contains(relativeTable.convert(fingerPosition, to: heroView)) {
                heroView!.targetLock(true, hero: relativeTable.tag)
                isTargetLocked = true
                return TargetHero(hero: hero, heroView: heroView!)
            }
            heroView!.targetLock(false, hero: relativeTable.tag)
        }
        return nil
    }
}
