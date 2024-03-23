//
//  End Of Round View Controller.swift
//  Dragon Guardian
//
//  Created by Daniel Beilfuss on 3/23/24.
//

import UIKit

class EndOfRoundViewController: UIViewController {
    
    // Title
    @IBOutlet weak var titleLabel: UILabel!
    
    // Messages & Stats
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var nextScreenMessageLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextBattleButton: UIButton!
    @IBOutlet weak var scoreboardButton: UIButton!
    
    // Properties
    let styleSheet = StyleSheet()
    var gameState: GameState = .inProgress
    var villagersSaved: Int = 0
    
    //MARK: - Text
    
    struct EndOfRoundData {
        let title: String
        var message: String
        let stats: String
        let nextScreenMessage: String
        let backButtonIsHidden: Bool
        let nextBattleButtonIsHidden: Bool
        let scoreboardButtonIsHidden: Bool
    }
    
    let pausedData = EndOfRoundData(
        title: "Game Paused", message: "",
        stats: "Total Villagers Saved this game: ##",
        nextScreenMessage: "The villagers still need your help!", 
        backButtonIsHidden: false,
        nextBattleButtonIsHidden: true, scoreboardButtonIsHidden: true
    )
    
    let victoryData = EndOfRoundData(
        title: "Victory!",
        message: "You have defeated the evil villains and saved ## villagers.",
        stats: "Total Villagers Saved:  ##",
        nextScreenMessage: "But Look!  Another group of villagers is under attack!",
        backButtonIsHidden: true,
        nextBattleButtonIsHidden: false,
        scoreboardButtonIsHidden: true
    )
    
    let defeatData = EndOfRoundData(
        title: "Defeat!",
        message: "You have been defeated by the evil villains and this group of villagers have perished.",
        stats: "Total Villagers Saved:  ##",
        nextScreenMessage: "",
        backButtonIsHidden: true,
        nextBattleButtonIsHidden: true,
        scoreboardButtonIsHidden: false
    )
    
    //MARK: - viewWillAppear
        
    func set(gameState: GameState, villagersSaved: Int) {
        // Properties
        self.gameState = gameState
        self.villagersSaved = villagersSaved
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Init
        initializeButtons()
        let data = initializeData(villagersSaved: villagersSaved)
        print(data)
        refreshScreen(data: data)
    }
    
    func initializeButtons() {
        backButton.tintColor = styleSheet.blue
        nextBattleButton.tintColor = styleSheet.green
        scoreboardButton.tintColor = styleSheet.red
    }
    
    func initializeData(villagersSaved: Int) -> EndOfRoundData {
        var thisData: EndOfRoundData = gameState == .inProgress ? pausedData : (gameState == .victory ? victoryData : defeatData)
        
        thisData.message = thisData.message.replacingOccurrences(of: "##", with: String(villagersSaved))
        
        return thisData
    }
    
    func refreshScreen(data: EndOfRoundData) {
        titleLabel.text = data.title
        messageLabel.text = data.message
        statsLabel.text = data.stats
        nextScreenMessageLabel.text = data.nextScreenMessage
        backButton.isHidden = data.backButtonIsHidden
        nextBattleButton.isHidden = data.nextBattleButtonIsHidden
        scoreboardButton.isHidden = data.scoreboardButtonIsHidden
    }
    
}
