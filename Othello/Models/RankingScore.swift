//
//  RankingScore.swift
//  Othello
//
//  Created by Admin on 23/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
class RankingScore{
    var id: Int
    var playerOneName: String
    var playerTwoName: String
    var againstComputer: Int
    var playerOneScore: Int
    var playerTwoScore: Int
    
    init(id: Int,playerOneName: String, playerTwoName: String, againstComputer: Int, playerOneScore: Int, playerTwoScore: Int){
        self.id = id
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
        self.againstComputer = againstComputer
        self.playerOneScore = playerOneScore
        self.playerTwoScore = playerTwoScore
    }
}
