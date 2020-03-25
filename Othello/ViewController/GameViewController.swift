//
//  GameViewController.swift
//  Othello
//
//  Created by Admin on 13.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
           
            let scene = MenuScene(size: view.bounds.size)
            
            scene.scaleMode = .aspectFill
                // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = false
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
