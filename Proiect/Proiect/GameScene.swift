//
//  GameScene.swift
//  Proiect
//
//  Created by Roxana Andreea on 06/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreGraphics

class GameScene: SKScene {

    let backButton = SKSpriteNode(imageNamed: "back")
    let restartButton = SKSpriteNode(imageNamed: "restart")
    var restartUIButton = UIButton()
    let deleteButton = SKSpriteNode(imageNamed: "delete")
    var controller: SecondViewController!
    let triangle = SKShapeNode()
    let delete = SKLabelNode()
    var nodeActive = -1;
    var buttonActive = (-1, -1)
    var triangleNodes: [SKShapeNode] = Array(repeating: SKShapeNode(), count: 81)
    var textNodes: [SKLabelNode] = Array(repeating: SKLabelNode(), count: 81)
    var gameStatus = SKLabelNode(fontNamed: "ArialMT")
    var buttons: [[SKLabelNode]] = Array(repeating: Array(repeating: SKLabelNode(), count: 3), count: 3)
    
    var board: Board!
    var level: Level!
    
    let leftOuterLeg = [0, 1, 4, 9, 16, 25, 36, 49, 64]
    let rightOuterLeg = [0, 3, 8, 15, 24, 35, 48, 63, 80]
    let bottomOuterLeg = [64, 66, 68, 70, 72, 74, 76, 78, 80]
    let leftInnerLeg = [16, 26, 27, 39, 40, 54, 55, 71, 72]
    let rightInnerLeg = [24, 34, 33, 45, 44, 58, 57, 73, 72]
    let topInnerLeg = [16, 17, 18, 19, 20, 21, 22, 23, 24]
    
    let normalColor = UIColor(red: 0.6235, green: 0.9569, blue: 0.8784, alpha: 1.0)
    let outerLegColor = UIColor(red: 0.2196, green: 0.8784, blue: 0.6235, alpha: 1.0) /* #38e09f */
    let innerLegColor = UIColor(red: 0.4824, green: 0.949, blue: 0.6627, alpha: 1.0) /* #7bf2a9 */
    
    var yPath = CGFloat(40.0)
    var yPos = CGFloat(600.0)
   
    let myScene = self
   
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.systemGray5
        level = ActionsManager.shared.level
        
        createBoard()
        printBoard()
    }
    
    func createBoard() {
        
        //first triangle node
         triangle.position = CGPoint(x: frame.midX, y: yPos)
         
         let path = UIBezierPath()
         path.move(to: CGPoint(x: -20.0, y: yPath - 40.0))
         path.addLine(to: CGPoint(x:20.0, y: yPath - 40.0))
         path.addLine(to:CGPoint(x:0.0, y: yPath))
         path.addLine(to:CGPoint(x:-20.0, y: yPath - 40.0))
         
         triangle.path = path.cgPath
         triangle.strokeColor = UIColor.black
         triangleNodes[0] = triangle
         addChild(triangle)
         
         //first text node
         let node = SKLabelNode(fontNamed: "Arial-BoldMT")
        // node.text = "0"
         node.fontSize = 20
         node.fontColor = UIColor.black
         node.horizontalAlignmentMode = .center
         node.position.x = frame.midX
         node.position.y = yPos + 5.0
         node.zPosition = 1
         textNodes[0] = node
         addChild(node)
         
         for i in 0...7 {
             createRow(_number: 3 + i * 2, _lastX: -20.0 * Double(i + 1))
             yPos = yPos - 40;
         }
         
         // background image
         let texture = SKTexture(imageNamed: "background")
         let background = SKSpriteNode(texture: texture)
         background.position = CGPoint(x: frame.midX, y: frame.midY)
         background.size.width = self.size.width
         background.size.height = self.size.height
         background.zPosition = -1.0
         addChild(background)
         
         outlineTriangles()
         //create the buttons
         createButtons()
              
         deleteButton.position.y = yPos - 138.0
         deleteButton.position.x = frame.midX + 135.0
         deleteButton.color = UIColor.darkGray
         deleteButton.size.width = 40.0
         deleteButton.size.height = 28.0
         deleteButton.zPosition = 1
         addChild(deleteButton)
         
         backButton.position.y = yPos + 348.0
         backButton.position.x = frame.midX - 140.0
         backButton.color = UIColor.darkGray
         backButton.size.width = 35.0
         backButton.size.height = 30.0
         backButton.zPosition = 1
         addChild(backButton)
         
         restartButton.position.y = yPos + 348.0
         restartButton.position.x = frame.midX + 140.0
         restartButton.color = UIColor.darkGray
         restartButton.size.width = 35.0
         restartButton.size.height = 30.0
         restartButton.zPosition = 1
         addChild(restartButton)
         
         gameStatus.position.y = yPos - 60.0
         gameStatus.position.x = frame.midX
         gameStatus.fontColor = UIColor.black
         gameStatus.fontSize = 25
         gameStatus.zPosition = 1
         gameStatus.text = ""
         addChild(gameStatus)
         
    }
    
    func printBoard() {
           
        if ActionsManager.shared.lastBoard != nil {
            board = ActionsManager.shared.lastBoard
        }
        else {
            board = Board(level)
        }
           for i in 0...80 {
               let value = board.getValue(pos: i)
                if !board.canModify[i] {
                    textNodes[i].fontColor = UIColor.black
                    textNodes[i].fontName = "Arial-BoldMT"
                }
                if board.correct[i] == .incorrect {
                    textNodes[i].fontColor = UIColor.red
                }
               textNodes[i].text = (value == 0) ? " " : String(value)
           }
       }
    
    func restartGame() {

        
        for i in 0...80 {
            if board.canModify[i] {
                board.values[i] = 0
                board.correct[i] = .notset
                textNodes[i].text = ""
            }
        }
        
        triangleNodes[nodeActive].fillColor = UIColor.clear
        nodeActive = -1
        
        
    }
    
   
    
    func checkBoard() {
        
        if board.finishedGame() {
            gameStatus.text = "Congratulations! You finished the game"
        }
    }
    
    var count = 1;
    func createRow(_number: Int, _lastX: Double) { //_lastX NEGATIV -> coltul din stanga al triunghiului din mijloc de pe randul anterior
        var lastX = _lastX
        for i in 0..._number - 1 { //lastX = -20 la al doilea rand
            let path2 = UIBezierPath()
            let triangle2 = SKShapeNode()
            triangle2.position = CGPoint(x: frame.midX, y: yPos)
            
            let node = SKLabelNode(fontNamed: "Arial-BoldMT")
            node.fontSize = 20
            node.fontColor = UIColor.darkGray
            node.horizontalAlignmentMode = .center
            node.position.x = frame.midX + CGFloat(lastX)
            
            if(i % 2 == 0) {
                path2.move(to: CGPoint(x: (lastX - 20.0), y: Double(yPath) - 80.0))
                path2.addLine(to: CGPoint(x: (lastX + 20.0), y: Double(yPath) - 80.0))
                path2.addLine(to:CGPoint(x: lastX, y: Double(yPath) - 40.0))
                path2.addLine(to:CGPoint(x:(lastX - 20.0), y: Double(yPath) - 80.0))
                node.position.y = yPos - yPath + 10.0
            }
            else { //lastX este deja crescut cu 20
                path2.move(to: CGPoint(x: (lastX - 20.0), y: Double(yPath) - 40.0))
                path2.addLine(to: CGPoint(x: (lastX + 20.0), y: Double(yPath) - 40.0))
                path2.addLine(to:CGPoint(x: lastX, y: -1.0 * Double(yPath)))
                path2.addLine(to:CGPoint(x: (lastX - 20.0), y: Double(yPath) - 40.0))
                node.position.y = yPos - yPath + 15.0
            }
            
            triangle2.path = path2.cgPath
            triangle2.fillColor = UIColor.clear
            triangle2.strokeColor = UIColor.black
            
            triangleNodes[count] = triangle2
            textNodes[count] = node
            addChild(triangleNodes[count])
            addChild(textNodes[count])
            
            count += 1
            lastX = lastX + 20;
        }
        
    }

    func colorLegs(){
        
        for i in 0...8 {
            triangleNodes[leftOuterLeg[i]].fillColor = UIColor.clear
            triangleNodes[rightOuterLeg[i]].fillColor = UIColor.clear
            triangleNodes[bottomOuterLeg[i]].fillColor = UIColor.clear
            
            triangleNodes[leftInnerLeg[i]].fillColor = UIColor.clear
            triangleNodes[rightInnerLeg[i]].fillColor = UIColor.clear
            triangleNodes[topInnerLeg[i]].fillColor = UIColor.clear
        }
        triangleNodes[16].fillColor = UIColor(red: 0.4824, green: 0.949, blue: 0.6627, alpha: 1.0) /* #7bf2a9 */
        triangleNodes[24].fillColor = UIColor(red: 0.4824, green: 0.949, blue: 0.6627, alpha: 1.0) /* #7bf2a9 */
        triangleNodes[72].fillColor = UIColor(red: 0.4824, green: 0.949, blue: 0.6627, alpha: 1.0) /* #7bf2a9 */
        
        
    }
  
    func outlineTriangles(){
        
        let bigTriangle = SKShapeNode()
        bigTriangle.position = CGPoint(x: frame.midX, y: yPos)
        let bigPath = UIBezierPath()
        bigPath.move(to: CGPoint(x: -20.0 * 9, y: Double(yPath) - 40.0))
        bigPath.addLine(to: CGPoint(x: 20.0 * 9, y: Double(yPath) - 40.0))
        bigPath.addLine(to: CGPoint(x: 0.0, y: yPos + 80.0 ))
        bigPath.addLine(to: CGPoint(x: -20.0 * 9, y: Double(yPath) - 40.0))
        //linia mica stanga
        bigPath.addLine(to: CGPoint(x: -20.0 * 3, y: Double(yPath) - 40.0))
        bigPath.addLine(to: CGPoint(x: -20.0 * 6 , y: yPos - 160.0))
        //linia mare mijloc
        bigPath.addLine(to: CGPoint(x: 20.0 * 6 , y: yPos - 160.0))
        //linia mica dreapta
        bigPath.addLine(to: CGPoint(x: 20.0 * 3, y: Double(yPath) - 40.0))
        //linia mare stanga
        bigPath.addLine(to: CGPoint(x: -20.0 * 3, y: yPos - 40.0))
        //linia mica mijloc
        bigPath.addLine(to: CGPoint(x: 20.0 * 3, y: yPos - 40.0))
        //linia mare dreapta
         bigPath.addLine(to: CGPoint(x: -20.0 * 3, y: Double(yPath) - 40.0))
        
        bigTriangle.path = bigPath.cgPath
        bigTriangle.strokeColor = UIColor.black
        bigTriangle.lineWidth = 2.5
        
        addChild(bigTriangle)
    }
    
    func createButtons(){
        
        for j in 0...2 {
            for k in 0...2{
                let button = SKLabelNode(fontNamed: "ArialMT")
                button.position.y = yPos - 200.0 - CGFloat(50.0 * Double(j - 1))
                button.position.x = frame.midX + CGFloat(80.0 * Double(k - 1))
                button.fontColor = UIColor.darkGray
                button.fontSize = 45
                button.text = String(j * 3 + k + 1)
                buttons[j][k] = button
                self.addChild(buttons[j][k])
            }
        }
        
        let separators = SKShapeNode()
        separators.position = CGPoint(x: frame.midX, y: yPos)
        let path = UIBezierPath()
        //left vertical line
        path.move(to: CGPoint(x: -20.0 * 2, y: Double(yPath) - 1.8 * 80.0))
        path.addLine(to: CGPoint(x: -20.0 * 2, y: Double(yPath) - 3.8 * 80.0))
        //right vertical line
        path.move(to: CGPoint(x: 20.0 * 2, y: Double(yPath) - 1.8 * 80.0))
        path.addLine(to: CGPoint(x: 20.0 * 2, y: Double(yPath) - 3.8 * 80.0))
        //top horizontal line
        path.move(to: CGPoint(x: -20.0 * 5.0, y: Double(yPath) - 2.5 * 80.0))
        path.addLine(to: CGPoint(x: 20.0 * 5.0, y: Double(yPath) - 2.5 * 80.0))
        //bottom horizontal line
        path.move(to: CGPoint(x: -20.0 * 5.0, y: Double(yPath) - 3.1 * 80.0))
        path.addLine(to: CGPoint(x: 20.0 * 5.0, y: Double(yPath) - 3.1 * 80.0))
        
        separators.path = path.cgPath
        separators.strokeColor = UIColor.clear
        separators.lineWidth = 2.5
        addChild(separators)
        
    }
    
    func selectedNode(_i: Int) {
        
        if nodeActive != -1 {
            let k = nodeActive
            triangleNodes[k].fillColor = UIColor.clear
        }
        if nodeActive == _i {
            nodeActive = -1
            triangleNodes[_i].fillColor = UIColor.clear
        }
        else {
            nodeActive = _i
            triangleNodes[_i].fillColor = UIColor.white
        }
    }
    
    func buttonPressed(_j: Int, _k: Int) {
        
        if buttonActive != (-1, -1) {
            let (a, b) = buttonActive
            buttons[a][b].fontColor = UIColor.darkGray
        }
        if buttonActive == (_j, _k) {
            buttonActive = (-1, -1)
            buttons[_j][_k].fontColor = UIColor.darkGray
        }
        else {
            buttonActive = (_j, _k)
        }
        
        if nodeActive != -1 {
            //get the selected triangle node's text value
            let node = textNodes[nodeActive]
            //calculate the value from the pressed button's coordinates
            let number =  _j * 3 + _k + 1
            //check if its correct and if we can modify the value
            let state = board.isValueCorrect(number: number, pos: nodeActive)
            let result = board.writeValue(number: number, pos: nodeActive)
            
            if result {
                node.text = String(number)
                if state == .incorrect {
                    //if the valuea is incorrect the text color will be red
                    node.fontColor = UIColor.red
                } else {
                    node.fontColor = UIColor.darkGray
                }
            }
        }
    }

    func deleteValue() {
        
        if nodeActive != -1 {
            let node = textNodes[nodeActive]
            node.text = ""
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            let touchedNodes = nodes(at: t.location(in: self))
            
            for i in 0...80 {
                if touchedNodes.contains(triangleNodes[i]) {
                    selectedNode(_i: i)
                }
            }
            
            for j in 0...2 {
                for k in 0...2{
                    if touchedNodes.contains(buttons[j][k]) {
                        buttonPressed(_j: j, _k: k)
                    }
                }
            }
            
            if deleteButton.contains(t.location(in: self)) {
                deleteValue()
            }
           
            if backButton.contains(t.location(in: self)) {
                ActionsManager.shared.rememberBoard(board: board)
                ActionsManager.shared.transition(self, toScene: .MainMenu, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            }
            
            if restartButton.contains(t.location(in: self)) {
                restartGame()
            }
        }
    }
}
