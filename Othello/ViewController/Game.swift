//
//  Game.swift
//  Othello
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SpriteKit

class Game: UIViewController {

    @IBOutlet weak var gameView: SKView!
    let scene = GameScene()
    override func viewDidLoad() {
        super.viewDidLoad()
        scene.scaleMode = .aspectFill
        scene.size = view.bounds.size
        gameView.presentScene(scene)
        gameView.ignoresSiblingOrder = false
        gameView.showsFPS = true
        gameView.showsNodeCount = true
    }
   
    func setNames(playerOneName: String, playerTwoName: String){
        scene.setNames(playerOneName: playerOneName, playerTwoName: playerTwoName)
    }
}


   

