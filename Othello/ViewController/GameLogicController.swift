//
//  GameLogicController.swift
//  Othello
//
//  Created by Admin on 16.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import SpriteKit

class GameLogicController {
    // currentPlayer true value represents player number one, flase player number two
    var currentPlayer: Bool = true
    var fields = Array(repeating: Array(repeating: OthelloField(xPosition: 0, yPosition: 0, position: CGPoint(x: 0, y: 0)), count: 8), count: 8)
    let moves = [[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1],[0, -1],[-1, -1]]
    var playerOneName = "Player"
    var playerTwoName = "Computer"
    var againstComputer = true
    var scene = SKScene()
    
    func initGame(scene: SKScene){
        self.scene = scene
        let scale = (UIScreen.main.bounds.width - 14) / 8
        let margin = (Int(UIScreen.main.bounds.width) - (Int(scale)) * 8) / 2
        
        var xPosition: CGFloat
        var yPosition: CGFloat
        
        for i in 0...7 {
            for j in 0...7 {
                xPosition = CGFloat(margin)  + CGFloat(j) *  scale
                yPosition = CGFloat(margin) + 7 * scale - CGFloat(i) * scale
                fields[i][j] = OthelloField(xPosition: j, yPosition: i, position: CGPoint(x: xPosition, y: yPosition))
                fields[i][j].setTokenValue(tokenValue: 0)
                scene.addChild(fields[i][j])
            }
        }
        
       
        fields[3][3].setTokenValue(tokenValue: 1)
        fields[4][4].setTokenValue(tokenValue: 1)
        fields[3][4].setTokenValue(tokenValue: 2)
        fields[4][3].setTokenValue(tokenValue: 2)
        markPotentialMoves()
    }
    
    func restartGame(){
        
        for i in 0...7 {
            for j in 0...7 {
                fields[i][j].setTokenValue(tokenValue: 0)
                fields[i][j].removeHint()
            }
        }
        
        currentPlayer = true
        fields[3][3].tokenValue = 1
        fields[3][3].setTokenValue(tokenValue: 1)
        fields[4][4].tokenValue = 1
        fields[4][4].setTokenValue(tokenValue: 1)
        fields[3][4].tokenValue = 2
        fields[3][4].setTokenValue(tokenValue: 2)
        fields[4][3].tokenValue = 2
        fields[4][3].setTokenValue(tokenValue: 2)
        markPotentialMoves()
    }
    
    func countPlayerOneTokens() -> Int{
        var numberOfTokens = 0
        for i in 0...7 {
            for j in 0...7 {
                if(fields[i][j].tokenValue == 1){
                    numberOfTokens = numberOfTokens + 1
                }
            }
        }
        return numberOfTokens
    }
    
    func countPlayerTwoTokens() -> Int{
        var numberOfTokens = 0
        for i in 0...7 {
            for j in 0...7 {
                if(fields[i][j].tokenValue == 2){
                    numberOfTokens = numberOfTokens + 1
                }
            }
        }
        return numberOfTokens
    }
    
    func score() -> String {
        return "\(countPlayerOneTokens()) - \(countPlayerTwoTokens())"
    }
    
    func makeMove(column: Int, row: Int){
        
        if(fields[row][column].possibleToMove){
            if(currentPlayer){
                fields[row][column].setTokenValue(tokenValue: 1)
                checkTokensToChange(column: column, row: row, tokenType: 1)
            }else{
                fields[row][column].setTokenValue(tokenValue: 2)
                checkTokensToChange(column: column, row: row, tokenType: 2)
            }
            if(!checkEndCondition()){
                changeCurrentPlayer()
            }else{
                endGame()
            }
            
            
        }
        // end condition to add
    }
    
    func computerMove(){
       
        
        var possibleMoves = [[Int]]()
        for i in 0...7{
            for j in 0...7{
                if(fields[i][j].possibleToMove){
                    possibleMoves.append([i, j])
                }
            }
        }
        var randomMove = Int(arc4random_uniform(UInt32(possibleMoves.count)))
        var i = possibleMoves[randomMove]
        makeMove(column: i[1], row: i[0])
        
    }
    
    func changeCurrentPlayer(){
        currentPlayer = !currentPlayer
        markPotentialMoves()

        if(!checkPossibleMoves()){
            changeCurrentPlayer()
        }
        if(againstComputer && !currentPlayer){
            let gameScene = scene as? GameScene
            gameScene!.setCurrentTurn()
              
            self.computerMove()
        
        }
        
    }
    
    
    
    func checkPossibleMoves() -> Bool{
        var possibleMovesExist = false
        for i in 0...7 {
            for j in 0...7 {
                if(fields[i][j].possibleToMove){
                    possibleMovesExist = true
                }
            }
       
    }
         return possibleMovesExist
    }
   
    // arguments are position and type of token placed
    func checkTokensToChange(column: Int, row: Int, tokenType: Int){
        
        var tokensPendingToSwap = [[Int]]()
        var columnIterator = column
        var rowIterator = row
        var possibleToSwap = true
        
        //check if there is any token above  to swap
        while(rowIterator > 0 && possibleToSwap){
            rowIterator = rowIterator - 1
            if(fields[rowIterator][columnIterator].tokenValue == 0 ){
            possibleToSwap = false
            }else if(fields[rowIterator][columnIterator].tokenValue != tokenType){
                tokensPendingToSwap.append([rowIterator , columnIterator])
            }else if(fields[rowIterator][columnIterator].tokenValue == tokenType && tokensPendingToSwap.count > 0){
                swapTokens(tokens: tokensPendingToSwap)
                possibleToSwap = false
            }else{
                possibleToSwap = false
            }
        }
        
        // clearing tokens that are pending to swap and possible to swap flag to stop
        possibleToSwap = true
        tokensPendingToSwap.removeAll()
        rowIterator = row
        
        
        
        //check if there is any token below to swap
        while(rowIterator < 7  && possibleToSwap){
            rowIterator = rowIterator + 1
            if(fields[rowIterator][columnIterator].tokenValue == 0 ){
                possibleToSwap = false
            }else if(fields[rowIterator][columnIterator].tokenValue != tokenType){
                tokensPendingToSwap.append([rowIterator , columnIterator])
            }else if(fields[rowIterator][columnIterator].tokenValue == tokenType && tokensPendingToSwap.count > 0){
                swapTokens(tokens: tokensPendingToSwap)
                possibleToSwap = false
            }else{
                possibleToSwap = false
            }
        }
        // clearing tokens that are pending to swap and possible to swap flag to stop
        possibleToSwap = true
        tokensPendingToSwap.removeAll()
        rowIterator = row
        
        //check if there is any token at right to swap
        while(columnIterator < 7  && possibleToSwap){
            columnIterator = columnIterator + 1
            if(fields[rowIterator][columnIterator].tokenValue == 0 ){
                possibleToSwap = false
            }else if(fields[rowIterator][columnIterator].tokenValue != tokenType){
                tokensPendingToSwap.append([rowIterator , columnIterator])
            }else if(fields[rowIterator][columnIterator].tokenValue == tokenType && tokensPendingToSwap.count > 0){
                swapTokens(tokens: tokensPendingToSwap)
                possibleToSwap = false
            }else{
                possibleToSwap = false
            }
        }
        // clearing tokens that are pending to swap and possible to swap flag to stop
        possibleToSwap = true
        tokensPendingToSwap.removeAll()
        columnIterator = column
        
        //check if there is any token at right to swap
        while(columnIterator > 0  && possibleToSwap){
            columnIterator = columnIterator - 1
            if(fields[rowIterator][columnIterator].tokenValue == 0){
                possibleToSwap = false
            }else if(fields[rowIterator][columnIterator].tokenValue != tokenType){
                tokensPendingToSwap.append([rowIterator , columnIterator])
            }else if(fields[rowIterator][columnIterator].tokenValue == tokenType && tokensPendingToSwap.count > 0){
                swapTokens(tokens: tokensPendingToSwap)
                possibleToSwap = false
            }else{
                possibleToSwap = false
            }
        }
        
        
        // clearing tokens that are pending to swap and possible to swap flag to stop
        possibleToSwap = true
        tokensPendingToSwap.removeAll()
        columnIterator = column
        rowIterator = row
        
        while(columnIterator > 0  && rowIterator > 0 && possibleToSwap){
            columnIterator = columnIterator - 1
            rowIterator = rowIterator - 1
            if(fields[rowIterator][columnIterator].tokenValue == 0 ){
                possibleToSwap = false
            }else if(fields[rowIterator][columnIterator].tokenValue != tokenType){
                tokensPendingToSwap.append([rowIterator , columnIterator])
            }else if(fields[rowIterator][columnIterator].tokenValue == tokenType && tokensPendingToSwap.count > 0){
                swapTokens(tokens: tokensPendingToSwap)
                possibleToSwap = false
            }else{
                possibleToSwap = false
            }
        }
        // clearing tokens that are pending to swap and possible to swap flag to stop
        possibleToSwap = true
        tokensPendingToSwap.removeAll()
        columnIterator = column
        rowIterator = row
        
        
        while(columnIterator < 7  && rowIterator > 0 && possibleToSwap){
            columnIterator = columnIterator + 1
            rowIterator = rowIterator - 1
            if(fields[rowIterator][columnIterator].tokenValue == 0 ){
                possibleToSwap = false
            }else if(fields[rowIterator][columnIterator].tokenValue != tokenType){
                tokensPendingToSwap.append([rowIterator , columnIterator])
            }else if(fields[rowIterator][columnIterator].tokenValue == tokenType && tokensPendingToSwap.count > 0){
                swapTokens(tokens: tokensPendingToSwap)
                possibleToSwap = false
            }else{
                possibleToSwap = false
            }
        }
        // clearing tokens that are pending to swap and possible to swap flag to stop
        possibleToSwap = true
        tokensPendingToSwap.removeAll()
        columnIterator = column
        rowIterator = row
        
        while(columnIterator > 0  && rowIterator < 7 && possibleToSwap){
            columnIterator = columnIterator - 1
            rowIterator = rowIterator + 1
            if(fields[rowIterator][columnIterator].tokenValue == 0 ){
                possibleToSwap = false
            }else if(fields[rowIterator][columnIterator].tokenValue != tokenType){
                tokensPendingToSwap.append([rowIterator , columnIterator])
            }else if(fields[rowIterator][columnIterator].tokenValue == tokenType && tokensPendingToSwap.count > 0){
                swapTokens(tokens: tokensPendingToSwap)
                possibleToSwap = false
            }else{
                possibleToSwap = false
            }
        }
        // clearing tokens that are pending to swap and possible to swap flag to stop
        possibleToSwap = true
        tokensPendingToSwap.removeAll()
        columnIterator = column
        rowIterator = row
        
        while(columnIterator < 7  && rowIterator < 7 && possibleToSwap){
            columnIterator = columnIterator + 1
            rowIterator = rowIterator + 1
            if(fields[rowIterator][columnIterator].tokenValue == 0 ){
                possibleToSwap = false
            }else if(fields[rowIterator][columnIterator].tokenValue != tokenType){
                tokensPendingToSwap.append([rowIterator , columnIterator])
            }else if(fields[rowIterator][columnIterator].tokenValue == tokenType && tokensPendingToSwap.count > 0){
                swapTokens(tokens: tokensPendingToSwap)
                possibleToSwap = false
            }else{
                possibleToSwap = false
            }
        }
   
    }
    func swapTokens(tokens: [[Int]]){
        for var i in tokens{
            if(fields[i[0]][i[1]].tokenValue == 1){
                fields[i[0]][i[1]].setTokenValue(tokenValue: 2)
            }else{
                fields[i[0]][i[1]].setTokenValue(tokenValue: 1)
            }
            
        }
    }
    
    func checkEndCondition() -> Bool{
        var playerOneMoves = checkPossibleMoves()
        currentPlayer = !currentPlayer
        var playerTwoMoves = checkPossibleMoves()
        currentPlayer = !currentPlayer
        return (!playerOneMoves && !playerTwoMoves)
    }
    
    func removeCurrentPotentialMoves(){
        for i in 0...7 {
            for j in 0...7 {
                fields[i][j].removeHint()
            }
        }
    }
    func markPotentialMoves(){
        removeCurrentPotentialMoves()
        var rowIterator: Int
        var columnIterator: Int
        var potentialMoves = [[Int]]()
        var possibleMovies = true
        var iterator = 0
        var marked = false
        for i in 0...7 {
            for j in 0...7 {
                if(fields[i][j].tokenValue == 0){
                    iterator = 0
                    marked = false
                    while(iterator < 7 && !marked){
                        
                        rowIterator = i
                        columnIterator = j
                        potentialMoves.removeAll()
                        possibleMovies = true
                        while(possibleMovies && (columnIterator + moves[iterator][1]) <= 7 && (columnIterator + moves[iterator][1]) >= 0 && (rowIterator + moves[iterator][0]) >= 0 && (rowIterator + moves[iterator][0]) <= 7){
                            rowIterator = rowIterator + moves[iterator][0]
                            columnIterator = columnIterator + moves[iterator][1]
                            
                            if((currentPlayer && fields[rowIterator][columnIterator].tokenValue == 2) || (!currentPlayer && fields[rowIterator][columnIterator].tokenValue == 1)){
                                potentialMoves.append([rowIterator, columnIterator])
                            }else if(potentialMoves.count > 0 && ((!currentPlayer && fields[rowIterator][columnIterator].tokenValue == 2) || (currentPlayer && fields[rowIterator][columnIterator].tokenValue == 1))){
                                showMoves(row: i, column: j)
                                possibleMovies = false
                                marked = true
                            }else{
                                possibleMovies = false
                            }
                        }
                        iterator = iterator + 1
                    }
                    
                               
                }
            }
        }
    }
    
    func showMoves(row: Int, column: Int){
            fields[row][column].markAsPossible()
    }
    
    func setNames(playerOneName: String, playerTwoName: String){
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
        againstComputer = false
    }
    
    func currentPlayerName() -> String{
        if(currentPlayer){
            return playerOneName
        }else{
            return playerTwoName
        }
    }
    func endGame(){
        print("Game Ended")
        let gameScene = scene as? GameScene
        gameScene!.showSaveScoreWindow()
    }
    
}

