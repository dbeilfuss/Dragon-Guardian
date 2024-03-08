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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var actionsRemainingLabel: UILabel!
    @IBOutlet weak var effectsLabel: UILabel!
    @IBOutlet weak var intentLabel: UILabel!
    
    // imageViews
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var targetImageView: UIImageView!
    
    // Constraints
    @IBOutlet weak var characterImageHeight: NSLayoutConstraint!
    
    // Properties
    var targetLock1: Bool = false
    var targetLock2: Bool = false
    var enemyNumber: Int = 0
    
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
        let xibView = Bundle.main.loadNibNamed("Character View", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    func displayCharacter(_ character: CharacterStats, tag: Int) {
        var imageName: String
        
        // Adjust imageHeight
        var imageHeightAdjustment: Int = 0
        switch character.name {
        case "Guardian":
            imageName = "\(character.name)\(character.level)"
            imageHeightAdjustment += (3-character.level) * 50
        case "Dragon":
            imageName = "\(character.name)\(character.level)"
            imageHeightAdjustment += (3-character.level) * 100
        default:
            imageName = character.name
        }
        characterImageHeight.constant -= CGFloat(imageHeightAdjustment)
        
        // uiImages
        characterImageView.image = UIImage(named: imageName)
        targetImageView.isHidden = true
        
        enemyNumber = tag
        displayStats(for: character)
        hideStats()

    }
    
    func hideStats() {
        nameLabel.text = ""
        healthLabel.text = ""
        blockLabel.text = ""
        actionsRemainingLabel.text = ""
        effectsLabel.text = ""
        intentLabel.text = ""
    }

    func displayStats(for character: CharacterStats) {
        nameLabel.text = character.name
        healthLabel.text = "HP: \(character.health)/\(character.health)"
        blockLabel.text = "Block: \(character.block)"
        if let safeActionsCount = character.actionsCount {
            actionsRemainingLabel.text = "Actions: \(String(safeActionsCount))"
        }
        effectsLabel.text = "Effect: \(character.statusEffects)"
        if let safeIntent = character.intent {
            intentLabel.text = "Intent: \(safeIntent)"
        }
    }
    
    func targetLock (_ receivedLock: Bool, hero: Int) { // when an action is locked on to this character
        switch hero {
        case 1:
            targetLock1 = receivedLock
        case 2:
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
}
