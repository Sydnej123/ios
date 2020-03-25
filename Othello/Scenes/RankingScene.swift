//
//  RankingScene.swift
//  Othello
//
//  Created by Admin on 14.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import SpriteKit

class RankingScene: SKScene {

    var db:DBConnector = DBConnector()
    var scores:[RankingScore] = []
    override func didMove(to view: SKView) {
        db.insert(id: 1, playerOneName: "Filip", playerTwoName: "Zasim", againstComputer: 0, playerOneScore: 34, playerTwoScore: 30)
        scores = db.read()
    }
    
}
