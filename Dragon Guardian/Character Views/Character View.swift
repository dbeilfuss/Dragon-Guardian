//
//  Character View.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/28/24.
//

import UIKit

class Character_View: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var actionsRemainingLabel: UILabel!
    @IBOutlet weak var effectsLabel: UILabel!
    @IBOutlet weak var intentLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    
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
        addSubview(xibView)
    }
    
    func displayCharacter(for character: CharacterStats) {
        characterImageView.image = UIImage(named: character.name)
        displayStats(for: character)

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
}
