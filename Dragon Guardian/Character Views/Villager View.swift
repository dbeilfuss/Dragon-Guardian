//
//  Villager View.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/2/24.
//

import Foundation

import UIKit

class VillagerView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var characterViewArea: UIView!

    @IBOutlet weak var villagerCountLabel: UILabel!
    @IBOutlet weak var subView: UIView!
    
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit() {
        
        // xib setup
        let xibView = Bundle.main.loadNibNamed("Villager View", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
        
        // UI Customization
        characterViewArea.layer.borderWidth = 5
        characterViewArea.layer.borderColor = UIColor.red.cgColor
    }

    func updateVillagerCount(_ villagerInfo: CharacterStats) {
        print("villager count updated to: \(villagerInfo.health)")
        villagerCountLabel.text = "Villagers: \(villagerInfo.health)"
    }
    
    
    
}
