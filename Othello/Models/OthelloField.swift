//
//  OthelloField.swift
//  Othello
//
//  Created by Admin on 18.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import SpriteKit
public class OthelloField: SKShapeNode{
    
    var xPosition: Int
    var yPosition: Int
    var token: SKShapeNode
    var hint =  SKShapeNode(circleOfRadius: 15)
    var tokenValue: Int = 0
    var possibleToMove: Bool = false
    init(xPosition: Int, yPosition: Int, position: CGPoint){
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.token = SKShapeNode(circleOfRadius: 15)
        super.init()
        self.path = CGPath(rect: CGRect(origin: .zero, size: CGSize(width: (UIScreen.main.bounds.width - 18)/8, height: (UIScreen.main.bounds.width - 18)/8)), transform: nil)
        self.position = position
        self.fillColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 1.0)
        addToken()
        addToolTip()
        
    }
    
    public required init(coder aDecoder: NSCoder){
        self.xPosition = 0
        self.yPosition = 0
        self.token = SKShapeNode(circleOfRadius: 15)
        super.init()
    }
  
    func addToken(){
        token = SKShapeNode(circleOfRadius: 15)
        token.fillColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 0.0)
        token.strokeColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 0.0)
        token.position = CGPoint(x: self.frame.width / 2,y: self.frame.width / 2)
        addChild(token)
    }
    
    func removeToken(){
        removeAllChildren()
    }
    
    func addToolTip(){
        hint.fillColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 0.0)
        hint.strokeColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 0.0)
        hint.position = CGPoint(x: self.frame.width / 2,y: self.frame.width / 2)
        addChild(hint)
    }
    
    func markAsPossible(){
        possibleToMove = true
        hint.strokeColor = UIColor.orange
    }
    
    func removeHint(){
        possibleToMove = false
        hint.fillColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 0.0)
        hint.strokeColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 0.0)
    }
    func setTokenValue(tokenValue: Int){
        self.tokenValue = tokenValue
        if(tokenValue == 1){
            token.fillColor = UIColor.white
            token.strokeColor = UIColor.white
        }else if(tokenValue == 2){
            token.fillColor = UIColor.black
            token.strokeColor = UIColor.black
        }else{
            token.fillColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 1.0)
            token.strokeColor = UIColor(red : 5/255, green: 122/255, blue: 9/255, alpha: 1.0)
        }
    }
}
