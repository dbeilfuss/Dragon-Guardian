//
//  Stats Bar View.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/18/24.
//

import UIKit

class StatsBarView: UIView {
    
    func viewInit() {
        
        // xib setup
        let xibView = Bundle.main.loadNibNamed("Stats Bar", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
        
        // UI Customization
//        villagerViewArea.layer.borderWidth = 5
//        villagerViewArea.layer.borderColor = UIColor.red.cgColor
//        targetImageView.isHidden = true
    }
    
}
