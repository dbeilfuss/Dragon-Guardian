//
//  actionCellSelectorDelegate.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/9/24.
//

import UIKit

extension BattleViewController: actionCellSelectorDelegate {
    
    //MARK: - UILongPressGestureRecognizer
    
    func actionSelected(hero: Int, fingerPosition: CGPoint) {
        print("actionSelected: hero: \(hero)")
        print("fingerPosition: \(fingerPosition)")
        
        toggleTargetVisibility(hero: hero)
        moveTargetSymbol(hero: hero, fingerPosition: fingerPosition)
    }
    
    func didDragToPoint(hero table: Int, fingerPosition: CGPoint) {
        moveTargetSymbol(hero: table, fingerPosition: fingerPosition)
    }
    
    func didEndDragging(hero: Int, fingerPosition: CGPoint, cellNumber: Int) {
        
        // identify target Character
        let relativeTable = identifyRelativeTable(hero: hero)
        let targetVillain: TargetVillain = identifyTargetCharacter(fingerPosition: fingerPosition, relativeTable: relativeTable)
        
        // UI
        toggleTargetVisibility(hero: hero)
        targetVillain.villainView?.targetLock(false, hero: hero)
        
        // BattleManager
        battleDelegate.actionPlayed(hero: hero, action: cellNumber, villainAttacked: targetVillain)
        
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
    
    func moveTargetSymbol(hero: Int, fingerPosition: CGPoint) {
        // identify correct target symbol - the target that moves with finger position
        let targetViews: [UIImageView] = [targetImage1, targetImage2]
        let thisTarget = targetViews[hero-1]
        
        let relativeTable: UITableView = identifyRelativeTable(hero: hero)
        let convertedPoint = relativeTable.convert(fingerPosition, to: view)
        
        // move target symbol
        thisTarget.center = convertedPoint
        
        let _ = identifyTargetCharacter(fingerPosition: fingerPosition, relativeTable: relativeTable)
        
    }
    
    func identifyRelativeTable(hero: Int) -> UITableView {
        // identify correct table - to base finger position off of
        let tableViews: [UITableView] = [hero1HandTableView, hero2HandTableView]
        return tableViews[hero-1]
        
    }
    
    //MARK: - Identify Target
    
    func identifyTargetCharacter(fingerPosition: CGPoint, relativeTable: UITableView) -> TargetVillain {
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
    
}
