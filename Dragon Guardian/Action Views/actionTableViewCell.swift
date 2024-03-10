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

    //MARK: - Properties
    var cellNumber: Int = 0
    var hero: Int = 1
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
            energyView.layer.cornerRadius = energyView.frame.width / 3
            attackView.layer.cornerRadius = 7
            
            // Gesture Recognizer (Long Press)
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            gestureRecognizer.minimumPressDuration = 0.15
            self.addGestureRecognizer(gestureRecognizer)
        }
        
    }
    
    // Cell
    func flipCellForHero() {
        if hero == 2 && !flipped {
            print("reversing order")
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
    func set(_ action: Action, cellNumber: Int, hero: Int, delegate: actionCellSelectorDelegate) {
        
        // cell properties
        self.hero = hero
        self.cellNumber = cellNumber
        actionSelectorDelegate = delegate
        
        // Cell
        flipCellForHero()
        
        // Card
        actionLabel.text = action.name
        actionImage.image = UIImage(named: action.name)
        
        // Stats
        energyLabel.text = String(action.cost)
        attackLabel.text = String(action.attackStrength ?? 0)
    }
    
    //MARK: - Action
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self.superview)

        switch gesture.state {
        case .began:
            print("Drag started")
            actionSelectorDelegate?.actionSelected(hero: hero, fingerPosition: location)
        case .changed:
            actionSelectorDelegate?.didDragToPoint(hero: hero, fingerPosition: location)
        case .ended:
            print("Drag ended")
            actionSelectorDelegate?.didEndDragging(hero: hero, fingerPosition: location, cellNumber: cellNumber)

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
    func actionSelected(hero: Int, fingerPosition: CGPoint)
    func didDragToPoint(hero: Int, fingerPosition: CGPoint)
    func didEndDragging(hero: Int, fingerPosition: CGPoint, cellNumber: Int)
}
