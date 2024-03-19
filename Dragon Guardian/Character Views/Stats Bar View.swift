//
//  Stats Bar View.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/18/24.
//

import UIKit

class StatsBarView: UIView {
    
    // Health
    @IBOutlet weak var healthProgressView: UIProgressView!
    @IBOutlet weak var healthLabel: UILabel!
    
    // Block
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var blockLabel: UILabel!
    
    // Protection
    @IBOutlet weak var protectedView: UIView!
    @IBOutlet weak var protectedLabel: UILabel!
    @IBOutlet weak var protectorImage: UIImageView!
    
    
    // Properties
    var hero: Hero?
    
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
        let xibView = Bundle.main.loadNibNamed("Stats Bar", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
        
    }
    
    func initializeHealthBar() {
        healthProgressView.transform = CGAffineTransform(scaleX: 1, y: 2.75)
        healthProgressView.tintColor = (hero != nil) ? .systemGreen : .red // appearance
    }
    
    //MARK: - Stats
    
    func displayStats(for character: CharacterStats) {
        
        // Properties
        self.hero = character.hero
        
        initializeHealthBar()
        
        updateHealth(to: character.health, maxHealth: character.maxHealth)
        updateBlock(to: character.block)
        
        updateProtection(with: character.protection.protectionArray, ids: character.protectionIDs)
        
        blockLabel.text = "Block: \(character.block)"
    }
    
    func updateHealth(to newHealth: Int, maxHealth: Int) {
        healthProgressView.setProgress(Float(newHealth) / Float(maxHealth), animated: true)
        healthLabel.text = "\(newHealth)/\(maxHealth)"
    }
    
    func updateBlock(to newBlock: Int) {
        if newBlock > 0 {
            blockView.isHidden = false
            blockLabel.text = String(newBlock)
        } else {
            blockView.isHidden = true
        }
    }
    
    func updateProtection(with protectionArray: [Protection], ids idArray: [Int]) {
        
        // Protected
        var totalProtection = 0
        for protection in protectionArray {
            totalProtection += protection.strength
        }
        
        if totalProtection > 0 {
            protectedView.isHidden = false
            protectedLabel.text = String(totalProtection)
        } else {
            protectedView.isHidden = true
        }
        
        // Protector
        if idArray.count > 0 {
            protectorImage.isHidden = false
        } else {
            protectorImage.isHidden = true
        }
    }
    
    func updateIntention(character: CharacterStats) {
        
    }
    
}
