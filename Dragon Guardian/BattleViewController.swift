//
//  BattleViewController.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/24/24.
//

import UIKit

class BattleViewController: UIViewController {
    
    //MARK: - UIElements
    
    // Hands TableViews
    @IBOutlet weak var hero1HandTableView: UITableView!
    @IBOutlet weak var hero2HandTableView: UITableView!
    
    // Villains StackViews
    @IBOutlet weak var hugeVillainsStackView: UIStackView!
    @IBOutlet weak var bigVillainsStackView: UIStackView!
    @IBOutlet weak var littleVillainsStackView: UIStackView!
    
    //MARK: - Properties
    let battleDelegate: battleViewControllerDelegate = BattleManager()

    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHands()
        initializeVillains()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.initialConfiguration()
        }
    }
    
    
//    func initialConfiguration() {
//        getNewHeroHands()
//        getNewVillains()
//    }
    
    func initializeHands() {
        hero1HandTableView.dataSource = self
        hero2HandTableView.dataSource = self
    }
    
    func initializeVillains(){
        let villainsList: VillainsList = battleDelegate.retrieveVillains()
        displayVillains(villains: villainsList.hugeVillains, stackView: hugeVillainsStackView)
        displayVillains(villains: villainsList.bigVillains, stackView: bigVillainsStackView)
        displayVillains(villains: villainsList.littleVillains, stackView: littleVillainsStackView)
        
        }
    
    }
    
    func displayVillains(villains: [Villain], stackView: UIStackView) {
        for villain in villains {
            let villainView = Character_View()
            villainView.translatesAutoresizingMaskIntoConstraints = false
            villainView.displayCharacter(for: villain.startingStats)
            
            // Constraints
            let aspectRatioConstraint = NSLayoutConstraint(item: villainView, attribute: .width, relatedBy: .equal, toItem: villainView, attribute: .height, multiplier: 1.0, constant: 0)
            villainView.addConstraint(aspectRatioConstraint)
            
            stackView.addArrangedSubview(villainView)
    }
    
    func getNewHeroHands() {
//        let heroHands = battleDelegate.retrieveHeroHands()
        
    }
    
}

//MARK: - Delegate: Battle View Controller

protocol battleViewControllerDelegate {
    func retrieveHeroHands() -> [[Action]]
    func retrieveVillains() -> VillainsList
}

//MARK: - Extension: Hands TableView
extension BattleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let heroHands = battleDelegate.retrieveHeroHands()
        
        switch tableView.tag {
        case 1:
            return heroHands[0].count
        case 2:
            return heroHands[1].count
        default:
            print("heroTableView error: cannot find correct tag when counting rows")
            return 5
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let heroHands = battleDelegate.retrieveHeroHands()
        var thisHeroHand: [Action] = []
        
        switch tableView.tag {
        case 1:
            thisHeroHand = heroHands[0]
        case 2:
            thisHeroHand = heroHands[1]
        default:
            print("heroTableView error: cannot find correct tag when determining which hand to use")
        }

        let actionName = thisHeroHand[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = actionName
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
