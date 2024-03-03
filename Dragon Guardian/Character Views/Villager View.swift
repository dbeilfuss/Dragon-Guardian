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
        let xibView = Bundle.main.loadNibNamed("Villager View", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("adding border")
        characterViewArea.layer.borderWidth = 10
    }
    
    func updateVillagerCount(_ villagerInfo: CharacterStats) {
        villagerCountLabel.text = String(villagerInfo.health)
        print("villager count updated to: \(villagerInfo.health)")
    }
    
}
