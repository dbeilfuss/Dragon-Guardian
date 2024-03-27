//
//  End Of Round View Controller.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/23/24.
//

import UIKit

class TransitionViewController: UIViewController {
    
    // Title
    @IBOutlet weak var titleLabel: UILabel!
    
    // Messages & Stats
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var villagerStatsLabel: UILabel!
    @IBOutlet weak var nextScreenMessageLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextBattleButton: UIButton!
    @IBOutlet weak var scoreboardButton: UIButton!
    
    // Properties
    let styleSheet = StyleSheet()
    var gameState: GameState = .inProgress
    var villagersSaved: Int = 0
    var roundNum: Int = 0
    var delegate: transitionScreenDelegate?
    
    //MARK: - Text
    
    struct transitionScreenData {
        let title: String
        var message: String
        var statsMessage: String
        var nextScreenMessage: String
        let backButtonIsHidden: Bool
        let nextBattleButtonIsHidden: Bool
        let scoreboardButtonIsHidden: Bool
    }
    
    let pausedData = transitionScreenData(
        title: "Game Paused", message: "",
        statsMessage: "You have ## villagers remaining!",
        nextScreenMessage: "Can you keep them safe until the end?",
        backButtonIsHidden: false,
        nextBattleButtonIsHidden: true, scoreboardButtonIsHidden: true
    )
    
    let victoryData = transitionScreenData(
        title: "Victory!",
        message: "You have defeated the evil villains",
        statsMessage: "and ## villagers remain.",
        nextScreenMessage: "Time passes.  You begin to grow.",
        backButtonIsHidden: true,
        nextBattleButtonIsHidden: false,
        scoreboardButtonIsHidden: true
    )
    
    let defeatData = transitionScreenData(
        title: "Defeat!",
        message: "You have been defeated by the evil villains and the villagers have perished.",
        statsMessage: "You died on round ##.",
        nextScreenMessage: "..💀..",
        backButtonIsHidden: true,
        nextBattleButtonIsHidden: true,
        scoreboardButtonIsHidden: false
    )
    
    //MARK: - viewWillAppear
        
    func set(gameState: GameState, villagersSaved: Int, roundNum: Int, delegate: transitionScreenDelegate) {
        // Properties
        self.gameState = gameState
        self.villagersSaved = villagersSaved
        self.roundNum = roundNum
        self.delegate = delegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Init
        initializeButtons()
        let data = initializeData(villagersSaved: villagersSaved, roundNum: roundNum)
        print(data)
        refreshScreen(data: data)
    }
    
    func initializeButtons() {
        backButton.tintColor = styleSheet.blue
        nextBattleButton.tintColor = styleSheet.green
        scoreboardButton.tintColor = styleSheet.red
    }
    
    func initializeData(villagersSaved: Int, roundNum: Int) -> transitionScreenData {
        var thisData: transitionScreenData = gameState == .inProgress ? pausedData : (gameState == .victory ? victoryData : defeatData)
        
        let statsData = gameState == .victory ? villagersSaved : roundNum
        
        thisData.statsMessage = thisData.statsMessage.replacingOccurrences(of: "##", with: String(statsData))
        
        return thisData
    }
    
    func refreshScreen(data: transitionScreenData) {
        titleLabel.text = data.title
        messageLabel.text = data.message
        villagerStatsLabel.text = data.statsMessage
        nextScreenMessageLabel.text = data.nextScreenMessage
        backButton.isHidden = data.backButtonIsHidden
        nextBattleButton.isHidden = data.nextBattleButtonIsHidden
        scoreboardButton.isHidden = data.scoreboardButtonIsHidden
    }
    
    //MARK: - Buttons
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func nextBattleButtonTapped(_ sender: UIButton) {
        delegate?.loadNextRound()
        self.dismiss(animated: true)
    }
    
    
}

protocol transitionScreenDelegate {
    func loadNextRound()
}
