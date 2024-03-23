//
//  HeroHandTableView.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/23/24.
//

import UIKit

class HeroHandTableView: UITableView {
    
    var hero: Hero = .guardian
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func set(hero: Hero) {
        self.hero = hero
    }
    
}
