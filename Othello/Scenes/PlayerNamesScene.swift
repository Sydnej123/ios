//
//  PlayerNamesScene.swift
//  Othello
//
//  Created by Admin on 14.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SpriteKit

class PlayerNamesScene: SKScene {
    var playerOneNameEntry: UITextField!
    var playerTwoNameEntry: UITextField!
    let playButton = SKShapeNode(rectOf: CGSize(width: 200, height: 50), cornerRadius: CGFloat(15))
    let playLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let backLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let backButton = SKShapeNode(rectOf: CGSize(width: 150, height: 50), cornerRadius: CGFloat(15))

    
    override func didMove(to view: SKView) {
        
        layoutScene()
    }
    
    func layoutScene(){
        self.scaleMode = .aspectFill
        backLabel.text = "< Back"
        backLabel.position = CGPoint(x: 40 ,y: UIScreen.main.bounds.height - 60)
        backLabel.fontColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        backLabel.fontSize = 24
        backLabel.name = "back"
        backButton.fillColor = UIColor.white
        backButton.position = CGPoint(x: 40  ,y:  UIScreen.main.bounds.height - 50)
        backButton.name = "backButton"
        
        
        
        let textFieldFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 30))
        playerOneNameEntry = UITextField(frame: textFieldFrame)
        playerOneNameEntry.placeholder = "Player One Name"
        playerOneNameEntry.font = UIFont(name: "Chalkboard SE Light", size: 24)
        playerOneNameEntry.textColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        playerOneNameEntry.textAlignment = NSTextAlignment.center
        backgroundColor = UIColor(red : 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        let bottomLine = CALayer()
        let bottomLine2 = CALayer()
        bottomLine.frame = CGRect(x:0.0, y:playerOneNameEntry.frame.height - 1, width: playerOneNameEntry.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0).cgColor
        playerOneNameEntry.borderStyle = UITextBorderStyle.none
        playerOneNameEntry.layer.addSublayer(bottomLine)
        
        bottomLine2.frame = CGRect(x:0.0, y:playerOneNameEntry.frame.height - 1, width: playerOneNameEntry.frame.width, height: 1)
        bottomLine2.backgroundColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0).cgColor
        
        playerTwoNameEntry = UITextField(frame: textFieldFrame)
        playerTwoNameEntry.placeholder = "Player Two Name"
        playerTwoNameEntry.font = UIFont(name: "Chalkboard SE Light", size: 24)
        playerTwoNameEntry.textColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        playerTwoNameEntry.textAlignment = NSTextAlignment.center
        
        
        
        playerTwoNameEntry.borderStyle = UITextBorderStyle.none
        playerTwoNameEntry.layer.addSublayer(bottomLine2)
        
        playerOneNameEntry.frame.origin.y = CGFloat(self.size.height/2 - 75)
        playerOneNameEntry.frame.origin.x = CGFloat(self.size.width/2 - 100)
    
        playerTwoNameEntry.frame.origin.y = CGFloat(self.size.height/2)
        playerTwoNameEntry.frame.origin.x = CGFloat(self.size.width/2 - 100)
        
        view!.addSubview(playerOneNameEntry)
        view!.addSubview(playerTwoNameEntry)
        
        playButton.name = "playButton"
        playButton.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2 - 75)
        playButton.fillColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        playButton.strokeColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        
        playLabel.text = "Play"
        playLabel.name = "play"
        playLabel.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2 - 88)
        addChild(backButton)
        addChild(backLabel)
        addChild(playButton)
        addChild(playLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch!.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if name == "play" || name == "playButton" {
                let nextScene = GameScene(size: self.size)
                
                let playerOneName: String
                let playerTwoName: String
                
                if(playerOneNameEntry.text!.count > 0){
                    playerOneName = playerOneNameEntry.text!
                }else{
                    playerOneName = "Player 1"
                }
                
                if(playerTwoNameEntry.text!.count > 0){
                    playerTwoName = playerTwoNameEntry.text!
                }else{
                    playerTwoName = "Player 2"
                }
                
                nextScene.setNames(playerOneName: playerOneName, playerTwoName: playerTwoName)
                playerOneNameEntry.removeFromSuperview()
                playerTwoNameEntry.removeFromSuperview()
                self.view?.presentScene(nextScene)
            }
            
           
        }
    }
}
