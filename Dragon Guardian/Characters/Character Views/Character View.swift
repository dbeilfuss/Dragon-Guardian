//
//  Character View.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/28/24.
//

import UIKit

class CharacterView: UIView {
    
    //MARK: - Outlets
    
    // Stats
    @IBOutlet weak var statsBarView: StatsBarView!

    // Energy Orb
    @IBOutlet weak var energyView: UIView!
    @IBOutlet weak var energyImage: UIImageView!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var energyTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var energyLeadingConstraint: NSLayoutConstraint!
    
    // imageViews
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var targetImageView: UIImageView!
    
    // Constraints
    @IBOutlet weak var characterImageHeight: NSLayoutConstraint!
    
    // Properties
    var targetLock1: Bool = false
    var targetLock2: Bool = false
    var enemyNumber: Int = 0
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
        // xib
        let xibView = Bundle.main.loadNibNamed("Character View", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    func displayCharacter(_ character: CharacterStats, index enemyNumber: Int) {
        var imageName: String
        self.enemyNumber = enemyNumber

        
        // Adjust imageHeight
        var imageHeightAdjustment: Int = 0
                
        switch character.hero {
        case .guardian:
            imageName = "\(character.name)\(character.level)"
            imageHeightAdjustment += (3-character.level) * 50
            hero = character.hero
        case .dragon:
            imageName = "\(character.name)\(character.level)"
            imageHeightAdjustment += (3-character.level) * 100
            hero = character.hero
        default:
            imageName = character.name
        }
        
        characterImageHeight.constant -= CGFloat(imageHeightAdjustment)
        
        
        // Character Images
        characterImageView.image = UIImage(named: imageName)
        targetImageView.isHidden = true
        
        displayStats(for: character)

    }

    func displayStats(for character: CharacterStats) {
        // Energy
        if hero != nil {
            updateEnergy(character.energy)
            
            if hero == .guardian {
                energyLeadingConstraint.isActive = true
            } else {
                energyTrailingConstraint.isActive = true
            }
        } else {
            energyView.alpha = 0
        }
        
        statsBarView.displayStats(for: character)
    }
    
    func targetLock (_ receivedLock: Bool, hero: Hero) { // when an action is locked on to this character
        switch hero {
        case .dragon:
            targetLock1 = receivedLock
        case .guardian:
            targetLock2 = receivedLock
        default:
            break
        }
        
        if targetLock1 || targetLock2 {
            targetImageView.isHidden = false
        } else {
            targetImageView.isHidden = true
        }
    }
    
    //MARK: - Update Character
    
    func updateCharacter(_ characterStats: CharacterStats) {
        statsBarView.updateCharacter(characterStats)
        updateEnergy(characterStats.energy)
    }
    
    func updateEnergy(_ energy: Int) {
        energyLabel.text = "\(energy)"
    }

}

//MARK: - Extensions
extension CharacterView: CharacterViewUpdateDelegate {
    
}
