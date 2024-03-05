//
//  BattleViewController.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/24/24.
//

import UIKit

class BattleViewController: UIViewController {
    
    //MARK: - UIElements
    
    // Hero Hands TableViews
    @IBOutlet weak var hero1HandTableView: UITableView!
    @IBOutlet weak var hero2HandTableView: UITableView!
    
    // Heros StackView
//    @IBOutlet weak var herosStackView: UIStackView!
    
    // Heros Views
    @IBOutlet weak var hero1View: UIView!
    @IBOutlet weak var hero2View: UIView!
    @IBOutlet weak var villagersView: UIView!
    
    // Villains StackViews
    @IBOutlet weak var hugeVillainsStackView: UIStackView!
    @IBOutlet weak var bigVillainsStackView: UIStackView!
    @IBOutlet weak var littleVillainsStackView: UIStackView!
    
    // Villains Constraints
    @IBOutlet weak var hugeVillainBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bigVillainBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var littleVillainBottomConstraint: NSLayoutConstraint!
    
    
    //MARK: - Properties
    let battleDelegate: battleViewControllerDelegate = BattleManager()

    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHands()
        initializeHeros()
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
    
    func initializeHeros() {
        let herosList = battleDelegate.retrieveHeros()
        displayHeros(herosList)
    }
    
    func initializeVillains(){
        let villainsList: VillainsList = battleDelegate.retrieveVillains()
        
        // Move up villainStackViews if there's room
        if villainsList.hugeVillains.isEmpty {
            bigVillainBottomConstraint.constant += 75
            littleVillainBottomConstraint.constant += 75
        }
        if villainsList.bigVillains.isEmpty {
            littleVillainBottomConstraint.constant += 75
        }
        
        // Display Villains
        displayVillains(villains: villainsList.hugeVillains, stackView: hugeVillainsStackView)
        displayVillains(villains: villainsList.bigVillains, stackView: bigVillainsStackView)
        displayVillains(villains: villainsList.littleVillains, stackView: littleVillainsStackView)
        
        }
    
    
    func displayHeros(_ heros: HerosList) {
        
        let guardianView: CharacterView = createCharacterView(heros.guardian.currentStats())
        let dragonView: CharacterView = createCharacterView(heros.dragon.currentStats())
        let villagersView: VillagerView = createVillagerView(villagers: heros.villagers.currentStats())
        
        addToView(childView: guardianView, parentView: hero1View)
        addToView(childView: dragonView, parentView: hero2View)
        addToView(childView: villagersView, parentView: self.villagersView)
        
        func addToView(childView: UIView, parentView: UIView) {
            parentView.addSubview(childView)
            NSLayoutConstraint.activate([
                childView.topAnchor.constraint(equalTo: parentView.topAnchor),
                childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                childView.leftAnchor.constraint(equalTo: parentView.leftAnchor),
                childView.rightAnchor.constraint(equalTo: parentView.rightAnchor)
            ])
        }

    }

    
    func displayVillains(villains: [Villain], stackView: UIStackView) {
        for villain in villains {
            let villainView: CharacterView = createCharacterView(villain.currentStats())
            stackView.addArrangedSubview(villainView)
        }
    }
    
    func createCharacterView(_ character: CharacterStats) -> CharacterView {
        // Setup CharacterView()
        let characterView = CharacterView()
        characterView.translatesAutoresizingMaskIntoConstraints = false
        characterView.displayCharacter(character)
        
        // Adjust Constraints
        let aspectRatioConstraint = NSLayoutConstraint(item: characterView, attribute: .width, relatedBy: .equal, toItem: characterView, attribute: .height, multiplier: 1.0, constant: 0)
        characterView.addConstraint(aspectRatioConstraint)
        
        return characterView
    }
    
    func createVillagerView(villagers: CharacterStats) -> VillagerView {
        // Setup CharacterView()
        let villagerView = VillagerView()
        villagerView.translatesAutoresizingMaskIntoConstraints = false
        villagerView.updateVillagerCount(villagers)
        
        return villagerView
    }
    
    func getNewHeroHands() {
//        let heroHands = battleDelegate.retrieveHeroHands()
        
    }
    
}

//MARK: - Delegate: BattleViewController

protocol battleViewControllerDelegate {
    func retrieveHeroHands() -> [[Action]]
    func retrieveHeros() -> HerosList
    func retrieveVillains() -> VillainsList
}

//MARK: - Extension: heroHandsTableViews - DataSource
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
