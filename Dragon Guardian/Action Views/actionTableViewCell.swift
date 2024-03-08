//
//  actionTableViewCell.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/6/24.
//

import UIKit

class actionTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    
    var cellNumber: Int = 0
    var hero: Int = 1
    var actionSelectorDelegate: actionCellSelectorDelegate?
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        
        func configureCell() {
            
            // Visual Style
            backgroundUIView.layer.cornerRadius = 10
            
            // Gesture Recognizer (Long Press)
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            gestureRecognizer.minimumPressDuration = 0.15
            self.addGestureRecognizer(gestureRecognizer)
        }
        
    }
    
    //MARK: - Set - Called by UITable during Setup
    func set(_ action: Action, cellNumber: Int, hero: Int, delegate: actionCellSelectorDelegate) {
        
        // cell properties
        self.cellNumber = cellNumber
        actionSelectorDelegate = delegate
        self.hero = hero
        
        // UI
        actionLabel.text = action.name
        actionImage.image = UIImage(named: action.name)
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
            actionSelectorDelegate?.didEndDragging(hero: hero, fingerPosition: location)

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
    func didEndDragging(hero: Int, fingerPosition: CGPoint)
}
