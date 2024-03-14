//
//  actionTableViewCell.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/6/24.
//

import UIKit

class actionTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    // Cell
    @IBOutlet weak var cellStackView: UIStackView!
    
    // card
    @IBOutlet weak var cardUIView: UIView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    
    // energy
    @IBOutlet weak var energyView: UIView!
    @IBOutlet weak var energyLabel: UILabel!
    
    // attack
    @IBOutlet weak var attackView: UIView!
    @IBOutlet weak var attackLabel: UILabel!
    
    // defend
    @IBOutlet weak var defendView: UIView!
    @IBOutlet weak var defendLabel: UILabel!
    
    // heal
    @IBOutlet weak var healView: UIView!
    @IBOutlet weak var healLabel: UILabel!
    
    // statusEffect
    @IBOutlet weak var statusEffectView: UIView!
    @IBOutlet weak var statusEffectLabel: UILabel!
    
    func statViews() -> [UIView] {[
        energyView,
        attackView,
        defendView,
        healView,
        statusEffectView
    ]}
    
    func statLabels() -> [UILabel] {[
        energyLabel,
        attackLabel,
        defendLabel,
        healLabel,
        statusEffectLabel
    ]}

    //MARK: - Properties
    var cellNumber: Int = 0
    var actionType: ActionType = .attack
    var hero: Heros = .dragon
    var flipped: Bool = false
    var actionSelectorDelegate: actionCellSelectorDelegate?
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        
        func configureCell() {
            
            // card
            cardUIView.layer.cornerRadius = 10
            
            // stats
            for view in statViews() {
                view.layer.cornerRadius = 7
            }
            
            // Gesture Recognizer (Long Press)
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            gestureRecognizer.minimumPressDuration = 0.15
            self.addGestureRecognizer(gestureRecognizer)
        }
        
    }
    
    // Cell
    func flipCellForHero() {
        if hero == .dragon && !flipped {
            // reverse the order of the subviews
            let arrangedSubviews = cellStackView.arrangedSubviews
            
            arrangedSubviews.forEach { view in
                cellStackView.removeArrangedSubview(view)
                //                view.removeFromSuperview()
            }
            
            arrangedSubviews.reversed().forEach { view in
                cellStackView.addArrangedSubview(view)
            }
            
            flipped = true
        }
    }
    
    //MARK: - Set - Called by UITable during Setup
    func set(_ action: Action, cellNumber: Int, hero: Heros, delegate: actionCellSelectorDelegate) {
        
        // cell properties
        self.hero = hero
        self.actionType = action.actionType
        self.cellNumber = cellNumber
        actionSelectorDelegate = delegate
        
        // Cell
        flipCellForHero()
        
        // Card
        actionLabel.text = action.name
        actionImage.image = UIImage(named: action.name)
        
        // Stats
        for view in statViews() {
            view.isHidden = true
        }
        
        energyView.isHidden = false
        energyLabel.text = String(action.cost)
        
        switch actionType {
        case .attack:
            attackView.isHidden = false
            attackLabel.text = String(action.attackStrength ?? 0)
        case .defend:
            defendView.isHidden = false
            defendLabel.text = String(action.defenseStrength ?? 0)
        case .protect:
            return
        }
        
    }
    
    //MARK: - Action
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self.superview)

        switch gesture.state {
        case .began:
            print("Drag started")
            actionSelectorDelegate?.actionSelected(actionType: actionType, hero: hero, fingerPosition: location)
        case .changed:
            actionSelectorDelegate?.didDragToPoint(actionType: actionType, hero: hero, fingerPosition: location)
        case .ended:
            print("Drag ended")
            actionSelectorDelegate?.didEndDragging(hero: hero, fingerPosition: location, cellNumber: cellNumber, actionType: actionType)

        default:
            break
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - Protocol - For Battle View Controller
protocol actionCellSelectorDelegate {
    func actionSelected(actionType: ActionType, hero: Heros, fingerPosition: CGPoint)
    func didDragToPoint(actionType: ActionType, hero: Heros, fingerPosition: CGPoint)
    func didEndDragging(hero: Heros, fingerPosition: CGPoint, cellNumber: Int, actionType: ActionType)
}
