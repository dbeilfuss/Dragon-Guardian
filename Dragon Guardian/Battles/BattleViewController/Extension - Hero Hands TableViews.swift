//
//  Extension - Hero Hands TableViews.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/26/24.
//

import UIKit

//MARK: - Extension: heroHandsTableViews - DataSource
extension BattleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let heroHands = battleManager.retrieveHeroHands()
        let thisTableView: HeroHandTableView = tableView as! HeroHandTableView
        
        switch thisTableView.hero {
        case .guardian:
            return heroHands[0].count
        case .dragon:
            return heroHands[1].count
        default:
            print("Error: heroTableView error: cannot find correct hero when counting rows")
            return 5
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // retrieve hero hand
        let thisTableView: HeroHandTableView = tableView as! HeroHandTableView
        let thisHero = thisTableView.hero
        let heroHands = battleManager.retrieveHeroHands()
        var thisHeroHand: [Action] = []
        
        switch thisTableView.hero {
        case .guardian:
            thisHeroHand = heroHands[0]
        case .dragon:
            thisHeroHand = heroHands[1]
        default:
            print("Error: heroTableView error: cannot find correct hero when determining which hand to use")
        }
        
        let heroEnergy: Int = battleManager.retrieveEnergy(for: thisHero)
        
        // create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionTableViewCell", for: indexPath) as! actionTableViewCell
        cell.set(thisHeroHand[indexPath.row], availableEnergy: heroEnergy, cellNumber: indexPath.row, hero: thisHero, delegate: self)
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    
}

//MARK: - Extension: herosHandsTableView - Delegate

extension BattleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Properties
        let thisTableView = tableView as! HeroHandTableView
        let hero = thisTableView.hero
        let action = battleManager.retrieveAction(hero: hero, action: indexPath.row)
        
        // Tip
        print(action)
        let tipLocation: TipLocation = hero == .guardian ? .left : .right
        viewTip(action: action, size: .large, location: tipLocation)
    }
    
}
