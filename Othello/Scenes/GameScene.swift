//
//  GameScene.swift
//  Othello
//
//  Created by Admin on 13.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
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
        backLabel.text = "< Back"
        backLabel.position = CGPoint(x: 40 ,y: UIScreen.main.bounds.height - 60)
        backLabel.fontColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        backLabel.fontSize = 24
        backLabel.name = "back"
        backButton.fillColor = UIColor.white
        backButton.position = CGPoint(x: 40  ,y:  UIScreen.main.bounds.height - 50)
        backButton.name = "backButton"
        
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
        let window = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 2), cornerRadius: CGFloat(30))
        let question = SKLabelNode()
        let yesButtonLabel = SKLabelNode()
        let noButtonLabel = SKLabelNode()
        let yesButton = SKShapeNode(rectOf: CGSize(width: 150, height: 50), cornerRadius: CGFloat(15))
        let noButton = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width - 20, height: 400), cornerRadius: CGFloat(15))
        
        window.fillColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        window.position = CGPoint(x: UIScreen.main.bounds.width/2 ,y: UIScreen.main.bounds.height / 2)
        self.addChild(window)
        
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
                if name == "back" || name == "backButton" {
                    let nextScene = MenuScene(size: self.size)
                    self.view?.presentScene(nextScene)
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
