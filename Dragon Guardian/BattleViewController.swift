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
    let battleDelegate: battleViewControllerDelegate = BattleManager()

    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
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
        hero1HandTableView.dataSource = self
        hero2HandTableView.dataSource = self
        targetImage1.isHidden = true
        targetImage2.isHidden = true
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
        
        let guardianView: CharacterView = createCharacterView(heros.guardian.currentStats(), tag: 1)
        let dragonView: CharacterView = createCharacterView(heros.dragon.currentStats(), tag: 2)
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
        // Setup CharacterView()
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
            table?.register(UINib(nibName: "actionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "actionViewTableViewCell")
            table?.backgroundColor = UIColor.clear
        }
    }
    
    //MARK: - Actions
    
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
        
        // retrieve hero hand
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
        
        // create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionViewTableViewCell", for: indexPath) as! actionViewTableViewCell
        cell.set(thisHeroHand[indexPath.row], cellNumber: indexPath.row, hero: tableView.tag, delegate: self)
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    
}

//MARK: - Extension: herosHandsTableView - Delegate
//extension BattleViewController: UITableViewDelegate {
//    
//}

//MARK: - Extension: actionCellSelector - Delegate
extension BattleViewController: actionCellSelectorDelegate {
    func actionSelected(hero: Int, fingerPosition: CGPoint) {
        print("actionSelected: hero: \(hero)")
        print("fingerPosition: \(fingerPosition)")
        
        toggleTargetVisibility(hero: hero)
        moveTarget(table: hero, fingerPosition: fingerPosition)

    }
    
    func didDragToPoint(hero table: Int, fingerPosition: CGPoint) {
        
//        print("actionSelected: hero: \(table)")
//        print("fingerPosition: \(fingerPosition)")
        
        moveTarget(table: table, fingerPosition: fingerPosition)
        
    }
    
    func didEndDragging(hero: Int, fingerPosition: CGPoint) {
        toggleTargetVisibility(hero: hero)
    }
    
    func toggleTargetVisibility(hero target: Int) {
        let targetViews: [UIImageView] = [targetImage1, targetImage2]
        let thisTarget = targetViews[target-1]
        
        if thisTarget.image == nil {
            thisTarget.image = UIImage(named: "Target")
        }
        
        thisTarget.isHidden = !thisTarget.isHidden
    }
    
    func moveTarget(table: Int, fingerPosition: CGPoint) {
        // identify correct target
        let targetViews: [UIImageView] = [targetImage1, targetImage2]
        let thisTarget = targetViews[table-1]
        
        // identify correct table - to base finger position off of
        let tableViews: [UITableView] = [hero1HandTableView, hero2HandTableView]
        let thisTable: UITableView = tableViews[table-1]
        let convertedPoint = thisTable.convert(fingerPosition, to: view)
        
        // move target
        thisTarget.center = convertedPoint
        
        // check for intersection with enemy
        var isTargetLocked: Bool = false
        let enemyStackViews: [UIStackView] = [littleVillainsStackView, bigVillainsStackView, hugeVillainsStackView]
        for stack in enemyStackViews {
            for enemy in
                    stack.arrangedSubviews {
                if let enemyCharacter = enemy as? CharacterView {
                    if !isTargetLocked && enemyCharacter.bounds.contains(thisTable.convert(fingerPosition, to: enemy)) {
                        enemyCharacter.targetLock(true)
                        isTargetLocked = true
                    } else {
                        enemyCharacter.targetLock(false)
                    }
                }
            }
        }
    }
    
}
