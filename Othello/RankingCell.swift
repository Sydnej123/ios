//
//  RankingCell.swift
//  Othello
//
//  Created by Admin on 26/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell {
   
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var playerOneName: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var playerTwoName: UILabel!
    func setScore(rankingScore: RankingScore, place: Int){
        
        if(rankingScore.playerOneScore > rankingScore.playerTwoScore){
            playerOneName.text = rankingScore.playerOneName
            playerTwoName.text = rankingScore.playerTwoName
            score.text = "\(rankingScore.playerOneScore) - \(rankingScore.playerTwoScore)"
        }else {
            playerOneName.text = rankingScore.playerTwoName
            playerTwoName.text = rankingScore.playerOneName
            score.text = "\(rankingScore.playerTwoScore) - \(rankingScore.playerOneScore)"
        }
        
        rank.text = String(place)
    }
}
