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
    @IBOutlet weak var villagerViewArea: UIView!

    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var targetImageView: UIImageView!
    
    
    // Population StackViews
    @IBOutlet weak var populationStackView1: UIStackView!
    @IBOutlet weak var populationStackView2: UIStackView!
    @IBOutlet weak var populationStackView3: UIStackView!
    @IBOutlet weak var populationStackView4: UIStackView!
    // StackView Constraints
    @IBOutlet weak var sv1BottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sv2BottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sv3BottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sv4BottomConstraint: NSLayoutConstraint!
    
    // Properties
    var targetLock1: Bool = false
    var targetLock2: Bool = false
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
        let xibView = Bundle.main.loadNibNamed("Villager View", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
        
        // UI Customization
        villagerViewArea.layer.borderWidth = 5
        villagerViewArea.layer.borderColor = UIColor.red.cgColor
        targetImageView.isHidden = true
    }

    func updateVillagerCount(_ villagerInfo: CharacterStats) {
        let population = villagerInfo.health
        
        // adjust stackView properties
        if population > 20 {
            if population <= 35 {
                sv1BottomConstraint.constant = 15
                populationStackView1.alpha = 0.9
            } else if population <= 45 {
                sv1BottomConstraint.constant = 25
                sv2BottomConstraint.constant = 15
                populationStackView1.alpha = 0.8
                populationStackView2.alpha = 0.9
            } else {
                sv1BottomConstraint.constant = 35
                sv2BottomConstraint.constant = 25
                sv3BottomConstraint.constant = 15
                populationStackView1.alpha = 0.7
                populationStackView2.alpha = 0.8
                populationStackView3.alpha = 0.9
            }
        }
        
        // add villager images
        populationLabel.text = "Villagers: \(population)"
        for i in 1...population {
            addVillagerImage(villagerNumber: i)
        }
    }
    
    func addVillagerImage(villagerNumber: Int) {
        
        let villagerName = "Villager\(Int.random(in: 1...2))"
        
        // choose stackView
        var stackView: UIStackView = populationStackView1
        if villagerNumber > 20 {
            if villagerNumber <= 35 {
                stackView = populationStackView2
            } else if villagerNumber <= 45 {
                stackView = populationStackView3
            } else {
                stackView = populationStackView4
            }
        }
        
        // add villager image
        if let villagerImage = UIImage(named: villagerName) {
            let imageView = UIImageView(image: villagerImage)
            imageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(imageView)
        }
    }
    
    func targetLock (_ receivedLock: Bool, hero: Hero) { // when an action is locked on to this character
        switch hero {
        case .guardian:
            targetLock1 = receivedLock
        case .dragon:
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
