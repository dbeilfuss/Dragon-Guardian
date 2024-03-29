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
    @IBOutlet weak var hero1HandTableView: HeroHandTableView!
    @IBOutlet weak var hero2HandTableView: HeroHandTableView!
        
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
    
    let hugeVillainBottomConstant: CGFloat = 300
    let bigVillainBottomConstant: CGFloat = 225
    let littleVillainBottomConstant: CGFloat = 150
    
    // Action Targets
    @IBOutlet weak var targetImage1: UIImageView!
    @IBOutlet weak var targetImage2: UIImageView!
    
    // Tips Views
    @IBOutlet weak var tipViewRight: TipsView!
    @IBOutlet weak var tipViewLeft: TipsView!
    
    
    
    
    //MARK: - Properties
    var gameState: GameState = .initializing
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
        initializeBattle()
    }
    
    func initializeBattle() {
        battleManager.setDelegate(self)
        initializeEnvironment()
        initializeHands()
        initializeHeros()
        initializeVillains()
        configureHandsTableViews()
        gameState = .inProgress
    }
    
    func initializeEnvironment() {

        let defaultEnvironment = ""
        if let environment: String = battleManager.retrieveEnvironment() {
            backgroundImage.image = UIImage(named: "\(environment)Background1")
        } else {
            print("failed to import environment")
            backgroundImage.image = UIImage(named: "\(defaultEnvironment)Background1")
        }
    }
    
    func initializeHands() {
        // Tables
        hero1HandTableView.set(hero: .guardian)
        hero2HandTableView.set(hero: .dragon)
        let tableViews: [UITableView] = [hero1HandTableView, hero2HandTableView]
        for table in tableViews {
            table.dataSource = self
            table.delegate = self
            table.showsVerticalScrollIndicator = false
        }
        
        // Targets
        targetImage1.isHidden = true
        targetImage2.isHidden = true
    }
    
    func resetHands() {
        hero1HandTableView.reloadData()
        hero2HandTableView.reloadData()
    }
    
    func initializeHeros() {
        let herosList = battleManager.retrieveHeros()
        displayHeros(herosList)
    }
    
    func resetHeros() {
        hero1View.subviews.forEach { $0.removeFromSuperview() }
        hero2View.subviews.forEach { $0.removeFromSuperview() }
        villagersView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func initializeVillains(){
        let villainsList: VillainsObjects = battleManager.retrieveVillains()
        
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
    
    func resetVillains() {
        hugeVillainBottomConstraint.constant = hugeVillainBottomConstant
        bigVillainBottomConstraint.constant = bigVillainBottomConstant
        littleVillainBottomConstraint.constant = littleVillainBottomConstant
    }
    
    func displayHeros(_ heros: HerosList) {
        
        let guardianView: CharacterView = createCharacterView(heros.guardian.currentStats(), index: heroNumbers.guardian.rawValue)
        let dragonView: CharacterView = createCharacterView(heros.dragon.currentStats(), index: heroNumbers.dragon.rawValue)
        let villagersView: VillagersView = createVillagerView(villagers: heros.villagers.currentStats())
        
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
            let villainView: CharacterView = createCharacterView(villain.currentStats(), index: i)
            stackView.addArrangedSubview(villainView)
            i += 1
        }
    }
    
    func createCharacterView(_ character: CharacterStats, index: Int) -> CharacterView {
        // Setup CharacterView
        let characterView = CharacterView()
        characterView.translatesAutoresizingMaskIntoConstraints = false
        characterView.displayCharacter(character, index: index, delegate: self)
        
        // Adjust Constraints
        let aspectRatioConstraint = NSLayoutConstraint(item: characterView, attribute: .width, relatedBy: .equal, toItem: characterView, attribute: .height, multiplier: 1.0, constant: 0)
        characterView.addConstraint(aspectRatioConstraint)
        
        return characterView
    }
    
    func createVillagerView(villagers: CharacterStats) -> VillagersView {
        // Setup CharacterView()
        let villagerView = VillagersView()
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
    
    //MARK: - Next Turn
    
    @IBAction func nextTurnButton(_ sender: UIButton) {
        if gameState == .inProgress {
            battleManager.nextTurn()
        }
    }
    
    //MARK: - Segue - Transition Screen

    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        transitionScreen()
    }
    
    func transitionScreen() {
        performSegue(withIdentifier: "battleToEndOfRoundSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "battleToEndOfRoundSegue" {
            let endOfRoundViewController = segue.destination as! TransitionViewController
            print(endOfRoundViewController.gameState)
            endOfRoundViewController.set(gameState: battleManager.getGamestate(), villagersSaved: battleManager.getVillagerCount(), roundNum: battleManager.getRoundNumber(), delegate: self)
            print(endOfRoundViewController.gameState)
        }
    }
    
}

//MARK: - Extention: TransitionScreenDelegate

extension BattleViewController: transitionScreenDelegate {
    func loadNextRound() {
        battleManager.loadNextRound()
    }
    
}

//MARK: - Extension: CharacterViewDelegate
extension BattleViewController: CharacterViewDelegate {
    func displayTip(enemyNumber: Int) {
        viewTip(villain: <#T##Villain#>, size: .large, location: <#T##TipLocation#>)
    }
    
}


//MARK: - Protocol: BattleViewControllerDelegate

protocol battleViewControllerDelegate {
    func setDelegate(_: battleManagerUIDelegate)
    func retrieveHeroHands() -> [[Action]]
    func retrieveEnergy(for: Hero) -> Int
    func retrieveHeros() -> HerosList
    func retrieveVillains() -> VillainsObjects
    func retrieveAction(hero: Hero, action: Int) -> Action
    func actionPlayed(actionType: ActionType, hero: Hero, action: Int, targetVillain: TargetVillain?, targetHero: Hero?)
    func nextTurn()
    func retrieveEnvironment() -> String?
    func getGamestate() -> GameState
    func getRoundNumber() -> Int
    func getVillagerCount() -> Int
    func loadNextRound()
}

//MARK: - Protocol: CharacterViewUpdateDelegate

protocol CharacterViewUpdateDelegate {
    func targetLock(_: Bool, hero: Hero)
    func updateCharacter(_: CharacterStats)
}
