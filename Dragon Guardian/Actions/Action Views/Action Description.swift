//
//  Action Description.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/18/24.
//

import UIKit

class ActionDescription: UIView {
    //MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit() {
        let xibView = Bundle.main.loadNibNamed("ActionDescription", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    //MARK: - Set
    func set(action: Action) {
        // Properties
        let name = action.name
        let cost = String(action.cost)
        let strength = String(action.attackStrength != nil ? action.attackStrength! : action.blockStrength!)
        let description = action.description
        let tip = action.tip
        
        var type: String = ""
        switch action.actionType {
        case .attack: type = "Attack"
        case.block: type = "Block"
        case.protect: type = "Protect"
        }
        
        // Labels
        nameLabel.text = name
        typeLabel.text = "Action Type: \(type)"
        costLabel.text = "Cost: \(cost)"
        strengthLabel.text = "Strength: \(strength)"
        descriptionLabel.text = description
        tipLabel.text = "Tip: \(tip)"
        
    }
    
}
