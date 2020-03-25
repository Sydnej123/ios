//
//  MenuScene.swift
//  Othello
//
//  Created by Admin on 13.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    let singlePlayerLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let twoPlayerLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let rankingLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    let titleLabel = SKLabelNode(fontNamed: "Chalkboard SE Light")
    
    let singlePlayerButton = SKShapeNode(rectOf: CGSize(width: 200, height: 50), cornerRadius: CGFloat(15))
    let twoPlayerButton = SKShapeNode(rectOf: CGSize(width: 200, height: 50), cornerRadius: CGFloat(15))
    let rankingButton = SKShapeNode(rectOf: CGSize(width: 200, height: 50), cornerRadius: CGFloat(15))
    
    
    override func didMove(to view: SKView) {
        layoutScene()
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red : 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        titleLabel.text = "OTHELLO GAME"
        titleLabel.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height - 75)
        titleLabel.fontColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        
        
        singlePlayerButton.name = "singleButton"
        singlePlayerButton.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2 + 75)
        singlePlayerButton.fillColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        singlePlayerButton.strokeColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        
        twoPlayerButton.name = "twoButton"
        twoPlayerButton.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2)
        twoPlayerButton.fillColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        twoPlayerButton.strokeColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        
        rankingButton.name = "rankingButton"
        rankingButton.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2 - 75)
        rankingButton.fillColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        rankingButton.strokeColor = UIColor(red : 32/255, green: 138/255, blue: 49/255, alpha: 1.0)
        
        rankingLabel.text = "Ranking"
        rankingLabel.name = "ranking"
        rankingLabel.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2 - 88)
        
        singlePlayerLabel.text = "Single Player"
        singlePlayerLabel.name = "single"
        singlePlayerLabel.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2 + 63)
        
        twoPlayerLabel.text = "Two Players"
        twoPlayerLabel.name = "two"
        twoPlayerLabel.position = CGPoint(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2 - 12)
        
        addChild(titleLabel)
        addChild(singlePlayerButton)
        addChild(singlePlayerLabel)
        addChild(twoPlayerButton)
        addChild(twoPlayerLabel)
        addChild(rankingButton)
        addChild(rankingLabel)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch!.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if name == "singleButton" || name == "single"{
                let crossScene = SKTransition.crossFade(withDuration: 0.5)
                let nextScene = GameScene(size: self.size)
                self.view?.presentScene(nextScene, transition: crossScene)
            }
            if name == "twoButton" || name == "two" {
                let crossScene = SKTransition.crossFade(withDuration: 0.5)
                let nextScene = PlayerNamesScene(size: self.size)
            
                self.view?.presentScene(nextScene, transition: crossScene)
            }
            
            if name == "rankingButton" || name == "ranking" {
                let crossScene = SKTransition.crossFade(withDuration: 0.5)
                let nextScene = RankingScene(size: self.size)
                self.view?.presentScene(nextScene, transition: crossScene)            }
        }
    }
}
