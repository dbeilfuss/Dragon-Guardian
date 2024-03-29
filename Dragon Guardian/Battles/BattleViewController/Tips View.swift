//
//  Action Description.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/18/24.
//

import UIKit

class TipsView: UIView {
    //MARK: - Outlets
    
    // Deprecating Outlets
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var typeLabel: UILabel!
//    @IBOutlet weak var costLabel: UILabel!
//    @IBOutlet weak var strengthLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var tipLabel: UILabel!
    
    // Stack View
    
    @IBOutlet weak var topLevelStackView: UIStackView!
    
    //MARK: - Styleets
    struct labelStyleSheet {
        let textStyle: UIFont.TextStyle
        let textColor: UIColor
        let lines: Int
    }

    let titleLabelStyleSheet = labelStyleSheet(
        textStyle: .largeTitle,
        textColor: .white,
        lines: 0
    )
    
    let dataLabelStyleSheet = labelStyleSheet(
        textStyle: .body,
        textColor: .white,
        lines: 0
    )
    
    //MARK: - Data
    
    struct TipsData {
        var title: String
        var info: [String?]
    }
    
    enum LabelType {
        case title
        case data
    }
    
    
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
        let xibView = Bundle.main.loadNibNamed("Tips View", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    //MARK: - Set
    
    func set(action: Action) {
        clearContents()
        var tipsData = createActionData(action)
        createLabels(tipsData)
    }
    
    func set(villain: Villain) {
        clearContents()
        
        var tipsData = createVillainData(villain)
        
        createLabels(tipsData)
        
    }
    
    func clearContents() {
        for subview in topLevelStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    func createActionData(_ action: Action) -> TipsData {
        
        var tipsData = TipsData(title: "", info: [])

        // Properties
        let name = action.name
        
        var type: String = ""
        switch action.actionType {
        case .attack: type = "Type: Attack"
        case.block: type = "Type: Block"
        case.protect: type = "Type: Protect"
        }
        
        let cost = "Cost: \(action.cost)"
        let strength = "Strength: \(action.attackStrength != nil ? action.attackStrength! : action.blockStrength!)"
        let description = "Description: \(action.description)"
        let tip = "Tip: \(action.tip)"
        
        // Set
        tipsData.title = name
        tipsData.info = [type, cost, strength, description, tip]
        
        return tipsData
    }
    
    func createVillainData(_ villain: Villain) -> TipsData {
        
        var tipsData = TipsData(title: "", info: [])

        // Properties
        let blockStrength = villain.stats.block
        let protectStrength = villain.stats.protection.sumOfProtection()
        let isProtecting = villain.stats.protectionIDs.count < 0
        let intent = villain.stats.intent
        
        // Text
        let name = villain.stats.name
        let level = "Level: \(String(villain.stats.level))"
        let block: String? = blockStrength > 0 ? "Block: \(String(blockStrength))" : nil
        let protect: String? = protectStrength > 0 ? "Protected: \(String(protectStrength))" : nil
        let protecting: String? = isProtecting ? "Currently Protecting another Villain." : nil
        let intention = "Current Intent: The Villain Intends to \(intent?.action.name ?? "think") on their next turn."
                
        // Set
        tipsData.title = name
        tipsData.info = [name, level, block, protect, protecting, intention]
        
        return tipsData
    }
    
    func createLabels(_ data: TipsData) {
        
        createLabelView(type: .title, text: data.title) // Title
        
        for textLine in data.info { // Data
            if textLine != nil {
                createLabelView(type: .data, text: textLine!)
            }
        }
    }
    
    func createLabelView(type: LabelType, text: String) {
        let label = UILabel()
        label.text = text
        applyFormatting(label: label, labelType: type)
        topLevelStackView.addArrangedSubview(label)
    }
    
    func applyFormatting(label: UILabel, labelType: LabelType) {
        let styleSheet = labelType == .title ? titleLabelStyleSheet : dataLabelStyleSheet
        
        label.font = UIFont.preferredFont(forTextStyle: styleSheet.textStyle)
        label.textColor = styleSheet.textColor
        label.numberOfLines = styleSheet.lines
        
    }
    
    // Dismiss
    
    @IBAction func xButton(_ sender: UIButton) {
        self.isHidden = true
    }
    
    
}
