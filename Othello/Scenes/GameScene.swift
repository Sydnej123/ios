//
//  GameScene.swift
//  Othello
//
//  Created by Admin on 13.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let window = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 3), cornerRadius: CGFloat(30))
    let background = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 2))
    let backLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let backButton = SKShapeNode(rectOf: CGSize(width: 150, height: 50), cornerRadius: CGFloat(15))
    let turnLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let playerOneNameLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let playerTwoNameLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let score = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let playerOneTokens = SKShapeNode(circleOfRadius: 15)
    let playerTwoTokens = SKShapeNode(circleOfRadius: 15)
    let restartLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let restartButton = SKShapeNode(rectOf: CGSize(width: 150, height: 50), cornerRadius: CGFloat(15))
    let logic = GameLogicController()
    var fields = Array(repeating: Array(repeating: OthelloField(xPosition: 0, yPosition: 0, position: CGPoint(x: 0, y: 0)), count: 8), count: 8)
    var isTouchAllowed = true
    var playerNameEntry = UITextField()
    func setNames(playerOneName: String, playerTwoName: String){
        logic.setNames(playerOneName: playerOneName, playerTwoName: playerTwoName)
    }
    
    
    override func didMove(to view: SKView) {
        
        layoutScene()
    }
    
    func layoutScene(){
        initGame()
        self.backgroundColor = UIColor.white
        self.scaleMode = .aspectFill
        // back button init
      
        
        // turn label init
        turnLabel.fontColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        turnLabel.position = CGPoint(x: UIScreen.main.bounds.width/2 ,y: UIScreen.main.bounds.height - 210)
        turnLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center

        // player one label
        playerOneNameLabel.fontColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        playerOneNameLabel.position = CGPoint(x: 0 ,y: UIScreen.main.bounds.height - 110)
        playerOneNameLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
       
       
        // player two label init
        playerTwoNameLabel.fontColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        playerTwoNameLabel.position = CGPoint(x: UIScreen.main.bounds.width ,y: UIScreen.main.bounds.height - 110)
        playerTwoNameLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        
        // score init
        score.fontColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        score.position = CGPoint(x: UIScreen.main.bounds.width/2 ,y: UIScreen.main.bounds.height - 160)
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
        // player one tokens color init
        playerOneTokens.fillColor = UIColor.white
        playerOneTokens.strokeColor = UIColor.black
        playerOneTokens.position = CGPoint(x:  40,y: UIScreen.main.bounds.height - 160)
        
        // player two tokens color init
        playerTwoTokens.fillColor = UIColor.black
        playerTwoTokens.position = CGPoint(x: UIScreen.main.bounds.width - 40,y: UIScreen.main.bounds.height - 160)
        
        restartButton.name = "restartButton"
        restartButton.position = CGPoint(x: UIScreen.main.bounds.width - 40, y: UIScreen.main.bounds.height - 50)
        
        //restartButton.fillColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        restartButton.fillColor = UIColor.white
        restartButton.strokeColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        
        restartLabel.text = "Restart"
        restartLabel.position = CGPoint(x: UIScreen.main.bounds.width - 50 ,y: UIScreen.main.bounds.height - 60)
        restartLabel.fontColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        restartLabel.fontSize = 24
        restartLabel.name = "restart"
        
        
        // adding childs
        addChild(backButton)
        addChild(backLabel)
        addChild(turnLabel)
        addChild(playerOneNameLabel)
        addChild(playerTwoNameLabel)
        addChild(score)
        addChild(playerOneTokens)
        addChild(playerTwoTokens)
        addChild(restartButton)
        addChild(restartLabel)
        showPlayerNames()
        setCurrentTurn()
    }
    
    func initGame(){
        logic.initGame(scene: self)
        setScore()
    }
    
    func restartGame(){
        logic.restartGame()
        setScore()
        showPlayerNames()
        setCurrentTurn()
    }
    
    func setScore(){
        score.text = logic.score()
    }
    func showPlayerNames(){
        if logic.againstComputer {
            playerOneNameLabel.text = "Player"
            
        }else {
            playerOneNameLabel.text = logic.playerOneName
        }
        
        if logic.againstComputer {
            playerTwoNameLabel.text = "Computer"
            
        }else {
            playerTwoNameLabel.text = logic.playerTwoName
        }
        
    }
    func setCurrentTurn(){
        turnLabel.text = "\(logic.currentPlayerName()) turn"
    }
    
    func showSaveScoreWindow(){
       
        let winnerLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
        let scoreLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
        let actionButtonLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
        let actionButton = SKShapeNode(rectOf: CGSize(width: 200, height: 50), cornerRadius: CGFloat(15))
        
        background.fillColor = UIColor(red : 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        background.name = "background"
        background.position = CGPoint(x: 0 ,y:0)
        
        
        window.strokeColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        window.fillColor = UIColor.white
        window.position = CGPoint(x: UIScreen.main.bounds.width/2 ,y: UIScreen.main.bounds.height / 2)
    
        winnerLabel.fontSize = 40
        winnerLabel.position = CGPoint(x: 0 ,y: UIScreen.main.bounds.height / 6 - 40)
        scoreLabel .fontSize = 32
         scoreLabel.text = "\(logic.countPlayerOneTokens()) - \(logic.countPlayerTwoTokens())"
        winnerLabel.position = CGPoint(x: 0 ,y: UIScreen.main.bounds.height / 6 - 70)
        
        actionButton.position = CGPoint(x: 0 ,y: UIScreen.main.bounds.height / -6 )
        actionButton.fillColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        
        
        
        actionButtonLabel.position = CGPoint(x: 0 ,y: (UIScreen.main.bounds.height / -6) - 9)
        
        
        if(logic.againstComputer){
            if(logic.winner){
                let bottomLine = CALayer()
                let textFieldFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 40))
                playerNameEntry = UITextField(frame: textFieldFrame)
                bottomLine.frame = CGRect(x:0.0, y:playerNameEntry.frame.height - 1, width: playerNameEntry.frame.width, height: 1)
                bottomLine.backgroundColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0).cgColor
                playerNameEntry.placeholder = "name"
                playerNameEntry.font = UIFont(name: "Chalkboard SE Light", size: 36)
                playerNameEntry.textColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
                playerNameEntry.textAlignment = NSTextAlignment.center
                playerNameEntry.borderStyle = UITextBorderStyle.none
                playerNameEntry.layer.addSublayer(bottomLine)
                playerNameEntry.frame.origin.y = CGFloat(UIScreen.main.bounds.height / 2 + 20)
                     playerNameEntry.frame.origin.x = CGFloat((UIScreen.main.bounds.width / 2) - 100 )
                view!.addSubview(playerNameEntry)
                winnerLabel.text = "You won!"
                winnerLabel.fontColor = UIColor(red: 5/255, green: 135/255, blue: 29/255, alpha: 1.0)
                scoreLabel.fontColor = UIColor(red: 5/255, green: 135/255, blue: 29/255, alpha: 1.0)
                actionButtonLabel.text = "Save score"
                actionButton.name = "saveButton"
                actionButtonLabel.name = "saveLabel"
                
            }else{
                winnerLabel.text = "You lose!"
                winnerLabel.fontColor = UIColor.red
                scoreLabel.fontColor = UIColor.red
                actionButtonLabel.text = "Play again"
                actionButton.name = "playAgain"
                actionButtonLabel.name = "playAgainLabel"
            }
           
        }else {
            winnerLabel.text = " \(logic.getWinnerName()) won!"
            winnerLabel.fontColor = UIColor(red: 5/255, green: 135/255, blue: 29/255, alpha: 1.0)
            scoreLabel.fontColor = UIColor(red: 5/255, green: 135/255, blue: 29/255, alpha: 1.0)
            actionButtonLabel.text = "Save score"
            actionButton.name = "saveButton"
            actionButtonLabel.name = "saveLabel"
        }
        
        winnerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
       
        window.addChild(winnerLabel)
        window.addChild(scoreLabel)
        window.addChild(actionButton)
        window.addChild(actionButtonLabel)
        self.addChild(background)
        self.addChild(window)
        
    }
    func hideScoreWindow(){
        background.removeFromParent()
        playerNameEntry.removeFromSuperview()
        window.removeAllChildren()
        window.removeFromParent()
    }
    func saveScore(){
        if(logic.againstComputer){
            if(playerNameEntry.text!.count > 0){
                logic.playerOneName = playerNameEntry.text!
            }else{
                logic.playerOneName = "Player"
            }
        }
        logic.saveScore()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isTouchAllowed){
            isTouchAllowed = false;
            let touch = touches.first
            let positionInScene = touch!.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name {
                if name == "restart" || name == "restartLabel" {
                    restartGame()
                }
                if name == "playAgain" || name == "playAgainLabel" {
                    hideScoreWindow()
                    restartGame()
                }
                if name == "saveButton" || name == "saveLabel" {
                     saveScore()
                     hideScoreWindow()
                     restartGame()
                }
                if name == "background" {
                    hideScoreWindow()
                    
                }
            }
            if let field = touchedNode as? OthelloField {
                logic.makeMove(column: field.xPosition, row: field.yPosition)
                setScore()
                setCurrentTurn()
            }
            
            if let field = touchedNode.parent as? OthelloField {
            
                logic.makeMove(column: field.xPosition, row: field.yPosition)
                setScore()
                setCurrentTurn()
                
            }
            isTouchAllowed = true
        }
       
    }
}
