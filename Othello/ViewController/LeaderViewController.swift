//
//  LeaderViewController.swift
//  Othello
//
//  Created by Admin on 26/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class LeaderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var rankingScores: [RankingScore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rankingScores = createArray()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func createArray() -> [RankingScore]{
        let db = DBConnector()
        return sortRanking(scores: db.read())
    }
    func sortRanking(scores: [RankingScore]) -> [RankingScore]{
        var sorted = scores
        for var i in 0...sorted.count - 2 {
            for var j in 0...sorted.count - 2 - i {
                if(max(sorted[j].playerOneScore, sorted[j].playerTwoScore) <  max(sorted[j + 1].playerOneScore, sorted[j + 1].playerTwoScore)){
                    var temp = sorted[j + 1]
                    sorted[j + 1] = sorted[j]
                    sorted[j] = temp
                }
            }
        }
        return sorted
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LeaderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingScores.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let score = rankingScores[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingCell") as! RankingCell
        cell.setScore(rankingScore: score, place: indexPath.row + 1)
        return cell
    }
}
