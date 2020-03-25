//
//  DBConnector.swift
//  Othello
//
//  Created by Admin on 23/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//
import SQLite3
import Foundation
class DBConnector{
    init(){
        db = openDatabase()
        createTable()
    }
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("Error opening database")
            return nil
        }else {
            print("Success")
            return db
        }
    }
    func createTable(){
        let createTableString = "CREATE TABLE IF NOT EXISTS rankingScore(Id INTEGER PRIMARY KEY, playerOneName TEXT, playerTwoName TEXT, againstComputer INTEGER, playerOneScore INTEGER, playerTwoScore INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if(sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK){
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Ranking table created")
            }else {
                print("Ranking table not created")
            }
        }else {
            print("Create table statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(id: Int,playerOneName: String, playerTwoName: String, againstComputer: Int, playerOneScore: Int, playerTwoScore: Int){
        
        let rankingScores = read()
        for score in rankingScores{
            if score.id == id{
                return
            }
        }
        let insertStatementString = "INSERT INTO rankingScore (Id, playerOneName, playerTwoName, againstComputer, playerOneScore, playerTwoScore) VALUES (?,?,?,?,?,?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK{
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (playerOneName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (playerTwoName as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 4, Int32(againstComputer))
            sqlite3_bind_int(insertStatement, 5, Int32(playerOneScore))
            sqlite3_bind_int(insertStatement, 6, Int32(playerTwoScore))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            }else {
                print("Could not insert row.")
            }
            
        }else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    
}
    
    func read() -> [RankingScore] {
        let queryStatementString = "SELECT * FROM rankingScore;"
        var queryStatement: OpaquePointer? = nil
        var scores: [RankingScore] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while(sqlite3_step(queryStatement) == SQLITE_ROW){
                let id = sqlite3_column_int(queryStatement, 0)
                let playerOneName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let playerTwoName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let againstComputer = sqlite3_column_int(queryStatement, 3)
                let playerOneScore = sqlite3_column_int(queryStatement, 4)
                let playerTwoScore = sqlite3_column_int(queryStatement, 5)
                scores.append(RankingScore(id: Int(id), playerOneName: playerOneName,playerTwoName: playerTwoName, againstComputer: Int(againstComputer), playerOneScore: Int(playerOneScore), playerTwoScore: Int(playerTwoScore) ))
                print("Query Result:")
                print("\(id) \(playerOneName) \(playerOneScore)")
            }
        }else{
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return scores
    }
    
}
