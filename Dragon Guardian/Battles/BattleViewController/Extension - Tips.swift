//
//  Extension - Tips.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/26/24.
//

import Foundation


//MARK: - Extension: Tips

extension BattleViewController {
    
    enum TipSize {
        case small
        case medium
        case large
    }
    
    enum TipLocation {
        case left
        case center
        case right
    }
        
    func viewTip(action: Action?, size: TipSize, location: TipLocation) {
        
        let tipView: TipsView = location == .left ? tipViewLeft : tipViewRight
        
        tipView.isHidden = false
        tipView.set(action: action)
    }
    
}
