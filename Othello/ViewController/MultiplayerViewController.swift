//
//  MultiplayerViewController.swift
//  Othello
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MultiplayerViewController: UIViewController {

    @IBOutlet weak var playerTwoNameEntry: UITextField!
    @IBOutlet weak var playerOneNameEntry: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let game = segue.destination as? Game else {return}
        var playerOneName: String
        var playerTwoName: String
        if(playerOneNameEntry.text!.count > 0){
            playerOneName = playerOneNameEntry.text!
        }else {
            playerOneName = "Player 1"
        }
        
        if(playerTwoNameEntry.text!.count > 0){
                   playerTwoName = playerTwoNameEntry.text!
               }else {
                   playerTwoName = "Player 2"
               }
        game.setNames(playerOneName:  playerOneName, playerTwoName: playerTwoName)
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
