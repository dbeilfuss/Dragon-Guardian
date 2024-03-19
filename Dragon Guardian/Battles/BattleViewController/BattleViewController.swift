//
//  BattleViewController.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 2/24/24.
//

import UIKit


class BattleViewController: UIViewController {
    
    //MARK: - Environment Elements
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: - UIElements
    
    // Hero Hands TableViews
    @IBOutlet weak var hero1HandTableView: UITableView!
    @IBOutlet weak var hero2HandTableView: UITableView!
        
    // Heros Views
    @IBOutlet weak var hero1View: UIView!
    @IBOutlet weak var hero2View: UIView!
    @IBOutlet weak var villagersView: UIView!
//    var guardianView: CharacterView = CharacterView()
//    var dragonView: CharacterView = CharacterView()
//    var villagersSubView: VillagerView = VillagerView()
    
    // Villains StackViews
    @IBOutlet weak var hugeVillainsStackView: UIStackView!
    @IBOutlet weak var bigVillainsStackView: UIStackView!
    @IBOutlet weak var littleVillainsStackView: UIStackView!
    
    // Villains Constraints
    @IBOutlet weak var hugeVillainBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bigVillainBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var littleVillainBottomConstraint: NSLayoutConstraint!
    
    // Action Targets
    @IBOutlet weak var targetImage1: UIImageView!
    @IBOutlet weak var targetImage2: UIImageView!
    
    
    
    //MARK: - Properties
    let battleManager: battleViewControllerDelegate = BattleManager()

    enum heroNumbers: Int {
        case dragon = 2
        case guardian = 1
        case villagers = 3
    }
    
    func getHeroNum(hero: Hero) -> Int {
        return hero == Hero.dragon ? heroNumbers.dragon.rawValue : (hero == .guardian ? heroNumbers.guardian.rawValue : heroNumbers.villagers.rawValue)
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        battleManager.setDelegate(self)
        initializeEnvironment()
        initializeHands()
        initializeHeros()
        initializeVillains()
        configureHandsTableViews()
    }
    
    func initializeEnvironment() {
        let environments = ["Desert", "Forest"]
        let environment: String = environments.randomElement()!
        backgroundImage.image = UIImage(named: "\(environment)Background1")
    }
    
    func initializeHands() {
        // Tables
        let tableViews: [UITableView] = [hero1HandTableView, hero2HandTableView]
        for table in tableViews {
            table.dataSource = self
            table.showsVerticalScrollIndicator = false
        }
        
        // Targets
        targetImage1.isHidden = true
        targetImage2.isHidden = true
    }
    
    func initializeHeros() {
        let herosList = battleManager.retrieveHeros()
        displayHeros(herosList)
    }
    
    func initializeVillains(){
        let villainsList: VillainsList = battleManager.retrieveVillains()
        
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
        
        let guardianView: CharacterView = createCharacterView(heros.guardian.currentStats(), tag: heroNumbers.guardian.rawValue)
        let dragonView: CharacterView = createCharacterView(heros.dragon.currentStats(), tag: heroNumbers.dragon.rawValue)
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
        var i = 0
        for villain in villains {
            let villainView: CharacterView = createCharacterView(villain.currentStats(), tag: i)
            villainView.tag = i
            stackView.addArrangedSubview(villainView)
            i += 1
        }
    }
    
    func createCharacterView(_ character: CharacterStats, tag: Int) -> CharacterView {
        // Setup CharacterView
        let characterView = CharacterView()
        characterView.translatesAutoresizingMaskIntoConstraints = false
        characterView.displayCharacter(character, tag: tag)
        
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
    
    func configureHandsTableViews() {
        let handTableView = [hero1HandTableView, hero2HandTableView]
        for table in handTableView {
            table?.dataSource = self
            table?.register(UINib(nibName: "actionTableViewCell", bundle: nil), forCellReuseIdentifier: "actionTableViewCell")
            table?.backgroundColor = UIColor.clear
        }
    }
    
    //MARK: - Actions
    
    func getNewHeroHands() {
//        let heroHands = battleDelegate.retrieveHeroHands()
        
    }
    
}


//MARK: - Extension: heroHandsTableViews - DataSource
extension BattleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let heroHands = battleManager.retrieveHeroHands()
        
        switch tableView.tag {
        case 1:
            return heroHands[0].count
        case 2:
            return heroHands[1].count
        default:
            print("Error: heroTableView error: cannot find correct tag when counting rows")
            return 5
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // retrieve hero hand
        let heroHands = battleManager.retrieveHeroHands()
        var thisHeroHand: [Action] = []
        
        switch tableView.tag {
        case 1:
            thisHeroHand = heroHands[0]
        case 2:
            thisHeroHand = heroHands[1]
        default:
            print("Error: heroTableView error: cannot find correct tag when determining which hand to use")
        }
        
        let thisHero: Hero = tableView.tag == 1 ? .guardian : .dragon
        let heroEnergy: Int = battleManager.retrieveEnergy(for: thisHero)
        
        // create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionTableViewCell", for: indexPath) as! actionTableViewCell
        cell.set(thisHeroHand[indexPath.row], availableEnergy: heroEnergy, cellNumber: indexPath.row, hero: thisHero, delegate: self)
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    
}

//MARK: - Extension: herosHandsTableView - Delegate
//extension BattleViewController: UITableViewDelegate {
//    
//}




//MARK: - Delegate: BattleViewController

protocol battleViewControllerDelegate {
    func setDelegate(_: battleManagerDelegate)
    func retrieveHeroHands() -> [[Action]]
    func retrieveEnergy(for: Hero) -> Int
    func retrieveHeros() -> HerosList
    func retrieveVillains() -> VillainsList
    func actionPlayed(actionType: ActionType, hero: Hero, action: Int, targetVillain: TargetVillain?, targetHero: Hero?)
}
