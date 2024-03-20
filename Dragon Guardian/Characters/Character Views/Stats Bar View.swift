//
//  Stats Bar View.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/18/24.
//

import UIKit

class StatsBarView: UIView {
    
    //MARK: - Outlets
    
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
    
    // Intention
    @IBOutlet weak var intentionView: UIView!
    @IBOutlet weak var intentionLabel: UILabel!
    @IBOutlet weak var intentionImage: UIImageView!
    
    
    // Properties
    let styleSheet = StyleSheet()
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
    
    func initializeUI() {
        // Health
        healthProgressView.transform = CGAffineTransform(scaleX: 1, y: 2.75)
        healthProgressView.tintColor = (hero != nil) ? styleSheet.green : styleSheet.red // appearance
        
        // Intentions
        intentionView.layer.cornerRadius = styleSheet.cornerRadius
    }
    
    //MARK: - Stats
    
    func displayStats(for character: CharacterStats) {
        
        // Properties
        self.hero = character.hero
        
        initializeUI()
        updateCharacter(character)
        
    }
    
    func updateCharacter(_ characterStats: CharacterStats) {
        updateHealth(to: characterStats.health, maxHealth: characterStats.maxHealth)
//        updateEnergy(characterStats.energy)
        updateBlock(to: characterStats.block)
        updateProtection(with: characterStats.protection.protectionArray, ids: characterStats.protectionIDs)
        updateIntention(characterStats.intent)
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
    
    func updateIntention(_ intention: VillainIntent?) {
        switch intention?.action.actionType {
        case .attack:
            // Properties
            let targetHero: Hero = intention!.targetHero!
            
            // UI
            intentionView.isHidden = false
            intentionView.backgroundColor = styleSheet.red
//            intentionImage.isHidden = false
            
            // Target Hero Icon
            var imageName: String = ""
            switch targetHero {
            case .dragon: imageName = "Dragon Icon"
            case .guardian: imageName = "Guardian Icon"
            case .villagers: imageName = "Villagers Icon"
            }
            intentionImage.image = UIImage(named: imageName)
            
            // Strength
            intentionLabel.text = String(intention!.action.attackStrength!)
            
        case .block:
            // UI
            intentionView.isHidden = false
            intentionView.backgroundColor = styleSheet.gray
            intentionLabel.text = String(intention!.action.blockStrength!)
            intentionImage.image = UIImage(named: "Block Icon")
//            intentionImage.isHidden = true
        case .protect:
            // UI
            intentionView.isHidden = false
            intentionView.backgroundColor = styleSheet.blue
            intentionImage.image = UIImage(named: "Protector Icon")
//            intentionImage.isHidden = true
        case .none:
            intentionView.isHidden = true
        }
        
        
    }
    
}
