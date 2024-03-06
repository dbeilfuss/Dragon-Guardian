//
//  actionViewTableViewCell.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/6/24.
//

import UIKit

class actionViewTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var actionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundUIView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ action: Action) {
        actionLabel.text = action.name
    }
    
}
